# Buoy for Swift

Add Buoy's developer tools to a native iOS app. Inspect the app on the device, connect it to Buoy Desktop, or use supported runtime actions through MCP.

The package bundles Network, Console, Storage, Env, Impersonate, Image Overlay, Images, Notifications, Routes, Scenarios, Time Machine, Events, and Assets, plus app metadata and native UI interaction support. Tools that depend on JavaScript stores or React rendering are not included.

This is a beta. The tools work with Buoy Desktop and MCP, but they do not match the React Native tools feature for feature; each section below lists what the native version leaves out. Report problems in the [issue tracker](https://github.com/Buoy-gg/Buoy-Swift/issues).

## Requirements

- An iOS app targeting iOS 16 or later, built with Xcode 16 or later.
- A Free or Pro Buoy account key. Get a key through your [Buoy account](https://buoy.gg).
- A development build for the first setup and verification.

Buoy ships as a prebuilt, signed framework for iOS devices and the iOS Simulator. Mac Catalyst and macOS are not supported.

## Add the package

In Xcode, choose **File > Add Package Dependencies…** and enter:

```text
https://github.com/Buoy-gg/Buoy-Swift.git
```

Use the dependency rule **Up to Next Minor Version** from `0.1.0`. While the package is in 0.x, a minor version can contain breaking changes. Add the **Buoy** library product to your iOS app target.

In a `Package.swift` manifest:

```swift
.package(url: "https://github.com/Buoy-gg/Buoy-Swift.git", .upToNextMinor(from: "0.1.0"))
```

Import it with `import Buoy`. Every tool is part of that one module.

## SwiftUI setup

In your app's Xcode Run scheme, add a `BUOY_LICENSE_KEY` environment variable containing your account key. The example reads that variable from the launched process. It is not automatically available when the app is launched outside that scheme; use your app's configuration mechanism for other internal builds.

This minimal app starts Buoy before creating a test URLSession. It gates both startup and the overlay with the app's `DEBUG` compilation condition:

```swift
import Foundation
import SwiftUI
import Buoy

@main
@MainActor
struct BuoyDemoApp: App {
    init() {
        #if DEBUG
        var config = BuoyConfig()
        config.deviceName = "Swift demo"
        config.licenseKey = ProcessInfo.processInfo.environment["BUOY_LICENSE_KEY"]
        Buoy.start(config)
        #endif
    }

    var body: some Scene {
        WindowGroup {
            #if DEBUG
            RequestCheckView().buoyDevTools()
            #else
            RequestCheckView()
            #endif
        }
    }
}

@MainActor
struct RequestCheckView: View {
    @State private var result = "Ready"

    var body: some View {
        VStack(spacing: 16) {
            Text(result)
            Button("Send test request") {
                Task { await sendRequest() }
            }
        }
        .padding()
    }

    private func sendRequest() async {
        guard let url = URL(string: "https://example.com/") else { return }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)
        defer { session.finishTasksAndInvalidate() }
        do {
            let (_, response) = try await session.data(from: url)
            if let response = response as? HTTPURLResponse {
                result = "HTTP \(response.statusCode)"
            }
        } catch {
            result = error.localizedDescription
        }
    }
}
```

In an existing app, keep your root view and providers. Start Buoy before initializing networking singletons or state objects that create URLSessions. Merely placing the call in App.init may be too late for clients created by stored-property initializers.

## Check the first request

Run the app in the iOS Simulator. Open the Buoy launcher and complete any account prompt. After account access is established, tap **Send test request**, open Network, and select the example.com request. Check its URL, status, and captured response. You can replace the sample URL with a test endpoint your team controls.

If the request is absent, confirm that the button made a fresh request, the session was created after Buoy.start, and capture is enabled. Requests that precede interception or account access may be unavailable. An app-level response does not guarantee that every transport path is captured.

## UIKit setup

Call `Buoy.start(config)` on the main actor early in your app lifecycle, using the same account configuration and compilation guard as the SwiftUI example. After creating your app window, install the overlay in its UIWindowScene:

```swift
#if DEBUG
Buoy.install(in: windowScene)
#endif
```

This fragment belongs in your existing scene delegate, where `windowScene` is the scene attached to your app window. The SwiftUI modifier and UIKit installer mount the same overlay; use the entry point appropriate to your app.

## Desktop and physical devices

Open [Buoy Desktop](https://github.com/Buoy-gg/Buoy-Desktop/releases/latest) and sign in separately. The default broker URL is `http://localhost:42831`, suitable for the iOS Simulator on the same Mac.

For an iPhone or iPad, point Buoy at the computer's LAN address. The quickest way is a `BUOY_SOCKET_URL` environment variable in your Run scheme, set to the address alone (`192.168.1.20`) or a full URL (`http://192.168.1.20:42831`). Buoy uses it only when `socketURL` is left at its default. To set it in code instead, do so before calling Buoy.start:

```swift
var config = BuoyConfig()
config.licenseKey = ProcessInfo.processInfo.environment["BUOY_LICENSE_KEY"]
if let brokerURL = URL(string: "http://192.168.1.20:42831") {
    config.socketURL = brokerURL
}
Buoy.start(config)
```

Replace the example IP address with your computer's address. Use your app's startup guard around this configuration. The property is `socketURL`, with an uppercase URL.

For a local development connection, merge these entries into your app's Info.plist, preserving any existing transport-security configuration:

```xml
<key>NSLocalNetworkUsageDescription</key>
<string>Connects to the Buoy desktop dashboard for debugging.</string>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
    <key>NSExceptionDomains</key>
    <dict>
        <key>192.168.0.0/16</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>
```

Since iOS 17, `NSAllowsLocalNetworking` alone no longer allows plain HTTP to a bare IP address, so the address also needs an `NSExceptionDomains` entry. Use the range that contains your computer's address (for example `10.0.0.0/8`), or the exact IP. CIDR keys require iOS 17; on iOS 16, list the exact IP. Limit these entries to the builds that include Buoy, for example with a separate Info.plist per build configuration.

On a physical device, Buoy.start prints a `[Buoy] setup:` line to the console when the URL still points at `localhost` or one of these entries is missing.

Allow local-network access when iOS asks, and ensure the device can reach the computer's broker port. These entries do not open a firewall or guarantee that a particular network or transport-security policy permits the connection. Check the connection error if it fails.

Select the Swift device in Desktop and repeat the request check. A device connection and a populated Network panel are separate checks. Keep the default per-install device ID unless you need to manage identity yourself; a custom ID must be unique for each device.

## Capture coverage

Network capture uses URLProtocol registration and hooks for default and ephemeral URLSession configurations. Install it before creating sessions or configurations that should be inspected. Libraries using those configurations can be captured; verify the actual client your app uses.

WebSocket tasks are excluded from this interception path. Do not assume coverage for background sessions, WebKit networking, or other native transports. Body and history limits can affect the data available in a request detail or remote snapshot.

Response overrides can change app behavior. Test with a disposable request, check the matching rule, and disable the override when finished. A captured request does not by itself prove that the backend received it or accepted its effects.

Network throttling offers No throttling, Slow (+500 ms), Very slow (+2000 ms), and Offline. Open it from Network's menu. The floating controls remain active when Network is minimized or capture is paused; Close turns throttling off. Profiles reset on app restart. Slow profiles delay dispatch without limiting bandwidth, and Offline takes priority over response overrides. The Network v6 adapter exposes `getNetworkConditions` and `setNetworkConditions` to Desktop and MCP. Like native response overrides, these controls require account admission and can run in an explicitly enabled internal Release build.

## MCP and interaction

Follow the [MCP setup guide](https://buoy.gg/buoy/latest/docs/mcp) to configure your editor and its process account. MCP data and action tools require Pro. Connect the Swift app, start with device discovery, and inspect the capabilities it advertises.

The UIKit interaction adapter supports inspecting and acting on supported UI elements. Coverage depends on the exposed view and accessibility information; verify the result in the app after an action. React Native-only tools and workflows are not automatically available in Swift.

Storage exposes `getRequiredKeys` with the configured key, backend, expected value/type, and description. The `image-overlay` adapter exposes `getSnapshot`, `listTargets`, `selectTarget`, `loadImage`, `setSettings`, `fitToScreen`, `resetSettings`, and `remove`. `loadImage` schedules an HTTP(S) image download; read the snapshot's `loading` and `error` fields to check its result. Settings use `opacity` (0–1), positive `scale`, point offsets `offsetX`/`offsetY`, and booleans `visible`, `locked`, `flipped`, `flippedY`, `showOutline`, and `autoTrack`.

Swift advertises only its implemented interaction and image actions. React render tracking, Expo cache controls, disk eviction, savings proofs, and in-process app reload are absent from its action list.

### Native MMKV

The SDK accepts existing MMKV instances through `BuoyMMKVRegistry.Instance`. Supply an instance id, encryption/read-only flags, a typed `read` closure, and throwing `write`/`remove` closures. Values are `BuoyMMKVValue.string`, `.number`, `.boolean`, or `.buffer`. Keep your app's type schema: native MMKV requires the matching getter for each stored value.

The Storage browser and `mmkv.snapshot/get/set/remove` use these registrations. Call `refresh(instanceId:)` after host writes, or from your storage-change observer, to record changes and update an open browser. Writes through Buoy refresh automatically. Read-only instances reject writes; internal Buoy keys are excluded. Binary values show their byte count and cannot be edited in the browser. History undo/jump remains limited to UserDefaults.

The SDK does not add an MMKV dependency to apps that do not use it.

### Scenarios

`BuoyScenarios.define(...)` registers a scenario from app code. Remote `scenarios.save` calls enter the draft inbox; review and accept a draft before running it. The runner checks native action availability and variables before the first step, records applied effects, and supports explicit undo recipes. Library entries and active effects survive restart. Execution is disabled in production builds. The native UI includes draft review, typed variable controls, a step preview, and a partial-run report with retry and cleanup actions.

Record a flow captures supported host taps and text, adds waits for observed navigation, and opens a review before saving. Buoy controls and secure text inputs are excluded. Recording requires a development build and an accessible host UI. Scroll gestures, slider replay, long-press replay, and native state-store shortcuts are not supported. Physical-touch capture still needs device QA; MCP-driven capture and replay have been exercised in the simulator.

## Access and lifecycle

Swift startup and overlay mounting do not automatically use the host app's debug-only condition. Apply your own compilation and authorization checks to both. An environment or user-role badge is presentation, not access control. TestFlight uses release builds, so a `DEBUG` guard normally excludes startup there; make any internal-build opt-in deliberate.

### Keeping Buoy out of Release

Swift packages cannot be linked only in Debug, so the Buoy framework is embedded in every build configuration. Nothing runs until `Buoy.start` is called: no URLProtocol registration, no swizzling, no overlay window and no network connection. With both calls behind `#if DEBUG`, a Release build contains the framework but never executes it. Buoy 0.1.0 adds about 9 MB to an uncompressed arm64 Release build, measured before App Store thinning and compression.

Calling Buoy.start again returns the existing runtime and can update a supplied account key. It does not reconfigure the running broker URL or device identity. Set the initial configuration before starting.

`Buoy.runtime?.stop()` stops the runtime connection and account lifecycle. `BuoyDevTools.uninstall()` removes the overlay. Do not treat either operation as proof that all installed networking hooks have been removed.

Account validation makes external requests, and device sessions can cross your LAN. Use a trusted development network and your app's authorization checks for users who can inspect or change its data. Consult [pricing](https://buoy.gg/pricing) for plan features; a paid plan does not add tools absent from this package.

## Connect app state to the tools

Network capture and native console capture start with `Buoy.start`. Other tools need app
configuration or view instrumentation:

| Tool | Integration |
| --- | --- |
| Storage | UserDefaults plus registered keychain items; `BuoyStorageModule.configure(requiredKeys:)` declares expected keys and values. Register typed host MMKV instances with `BuoyMMKVRegistry.shared.register(...)`. |
| Env | `BuoyEnv.configure(vars:required:)` supplies the values and validation rules. |
| Impersonate | `BuoyImpersonate.configure` supplies user search and host callbacks. Data-clearing options are passed to the host; they do not clear JavaScript stores. |
| Image Overlay | Mark targets with `.buoyImageOverlayTarget("Profile photo")`, or use free placement. |
| Images | Use `BuoyAsyncImage` to exercise loading, failure, retry, blank and replacement states. `.buoyImage(url:)` measures an existing view without controlling its content. |
| Notifications | Call `BuoyNotifications.install()` early, after your app sets its own `UNUserNotificationCenter` delegate (or pass that delegate to it); capture starts there. Forward the APNs registration callback to `BuoyNotifications.observeDeviceToken(_:)`. Local test delivery still requires notification permission. |
| Routes | Supply route patterns and navigation callbacks with `BuoyRoutes.configure`. Mark screens with `.buoyRoute(...)`, or supply the host's navigation stack. |

For example, preserve your image's phase-specific content while enabling Images controls:

```swift
BuoyAsyncImage(url: imageURL) { phase in
    switch phase {
    case .empty: ProgressView()
    case .success(let image): image.resizable().scaledToFit()
    case .failure: Text("Image unavailable")
    @unknown default: EmptyView()
    }
}
```

For accurate duplicate-route pushes and pops, pass `stack:` to `BuoyRoutes.configure`.
Return `[RouteStackItem]` from root to top, using a stable, unique `key` for each entry,
and call `BuoyRoutes.refreshStack()` whenever that navigation state changes. Appearance-only
tracking cannot distinguish two stack entries with the same pathname reliably.

Native image records aggregate by URL. Expo disk-cache operations and WebP savings proof
are unavailable. Network overrides stay inactive until account access is established,
including during initial account verification at startup.

### Time Machine

The native tool captures UserDefaults and registered MMKV instances, preserving their value types. It supports previews, item exclusions and scopes, named restore points, duplication, and live restore. Restores save a safety point before writing enabled providers. Source switches persist across launches and apply to both capture and restore, including explicit source requests. Disabled sources remain untouched; their preview items are marked as not applied. Disabling Route also prevents navigation during restore.

Register additional state with `BuoyTimeMachine.registerProvider(BuoySnapshotProvider(...))`. A provider returns keyed `BuoySnapshotItem` values and implements `restoreItem`; a nil payload means remove that item. Payloads must be JSON compatible. Provider capture failures abort the operation before restoration starts. Restore failures appear in the per-source outcome.

Native capabilities expose 11 actions. In-process reload, fresh-install baselines, and wipe-all are not available. Keychain is excluded from the default provider. The floating bar supports capture, point selection, live restore, and a ten-second Undo action. RN's full preview grouping and filtering workflow is still pending.

### Events

Events combines captured Network, UserDefaults/MMKV, and Routes activity. The native UI supports source filters, search, pause, clear, copy, and JSON detail. MCP exposes `clearEvents`, `setEnabledSources`, and `exportEvents`. UI and remote consumers retain their own source selections, so turning a remote source off does not stop the open on-device view from capturing it.

Native export supports the common presets and JSON, Markdown, plain text, and Mermaid output. Supported settings are `format`, `includeEventData`, `includeSource`, `includeStatus`, `includeTitle`, `includeSubtitle`, `includeSummaryHeader`, `filterMode`, `filterSources`, `dataSizeThreshold`, and `timestampFormat`. Other settings are rejected. The Copy Settings screen selects the export preset and whether to include event data. On-device copy respects selected sources. Source-specific interactive detail pages remain pending; payloads inherit source snapshot limits. React store and render events are unavailable.

### Assets

Assets scans loose resources in the app bundle, measures their file sizes, detects duplicate content, and saves a comparison baseline. Its nine MCP actions use the existing Assets contract. Add an app resource bundle with `BuoyAssets.registerBundle(...)`; call `BuoyAssets.markLoaded(url)` after the app loads a resource. Buoy's UI bundles and preview images are excluded from capture.

Coverage is partial: compiled `Assets.car` files appear as aggregate records, embedded bundles require explicit registration, and loaded status is host reported. An unobserved resource is not necessarily unused. Scale-variant and decoded-memory findings are not implemented. Read `scanStatus.coverage` and `warnings` before interpreting the inventory.

### Privacy manifest

The framework includes `PrivacyInfo.xcprivacy` with the app-scoped UserDefaults reason `CA92.1`. Buoy reads the host app's defaults and stores its own tool preferences there. Review the host's privacy disclosures for the diagnostic data you allow Buoy to capture and send to your broker. The required-reason declaration does not describe every possible host payload or replace the host's privacy review.

## License and support

Buoy is proprietary software. See the [terms](https://buoy.gg/terms). Report Swift integration issues in the [issue tracker](https://github.com/Buoy-gg/Buoy-Swift/issues), including the package revision, iOS version, build configuration, client library, and reproduction steps.
