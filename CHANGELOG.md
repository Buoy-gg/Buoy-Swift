# Changelog

## 0.1.4 (beta)

- Ask Buoy comes to Swift. Chat with it to check your app and use tools. Set up your model with `AskBuoyConfig` in `Buoy.start`.
- Adds Clock, Lifecycle, Location, Permissions, Bench, Highlight, and Debug Borders. The build now reads the full tool list from SwiftPM. Ask Buoy's tool data ships in the framework too.
- Long chats no longer freeze when the keyboard opens. The last reply and its buttons stay in view. The Changes list fits above the keyboard. Sheet headers stay on screen. The small chat icon sits below the status bar.
- Tool calls keep number values, such as status codes and delays. Fields that take more than one type now accept those types. Undo can put back a number you removed from Storage.
- Screen checks skip Buoy's own chat and controls. Screen reads hide them when asked.
- Images report Swift as their source. Blank mode hides images that are on screen. Image Overlay reset clears both flips.
- Storage keeps new events when you switch panel modes. Web call times now count the added wait.
- Route moves wait in order and check the shown stack. A jump pushes a screen. With no live stack, the result says it is not checked.
- Dev-only parts now work in your dev builds. Before, the binary always acted like a live build. Highlight did not record draws. Clock, Location and Lifecycle did not start. The Time Machine bar stayed hidden. Ask Buoy said "Release build" and blocked changes. Dev tokens were turned away. Buoy now checks your app's build when it runs.
- Dev builds now work without a paid plan, like React Native. You still need to sign in or set a key. Live builds, like TestFlight and the App Store, still need a plan.
- Two calls to the same web address are two rows, even 10 ms apart. A fast retry after a 401 no longer goes missing.
- The image savings check says when no WebP encoder is set up. It used to say ok with no file. Set `ImageSavings.encodeWebP` to add one.
- Ask Buoy can reset the route stack with `reset` on `navigate`.
- Opening a link no longer says it is inactive. Time Machine's tool text now lists its native reset tools. It now says which Keychain keys it can save.

## 0.1.3 (beta)

- Sign in with a code. Set `config.signIn = BuoySignInConfig()`, then tap "BUOY · Sign in". The app shows a QR code and a short code. Scan it, or type it at buoy.gg/activate, then tap Allow. This works in TestFlight builds with no key in the app. Add `app:` and your bundle id to your sites at buoy.gg first.
- Settings show "Signed in with Buoy" with a Sign out button while you're signed in.

## 0.1.2 (beta)

- Fixes a crash at launch in apps that call `BuoyNotifications.install()`. Versions 0.1.0 and 0.1.1 read notification permissions in a way that fails a Swift runtime check, so update to 0.1.2 before enabling Notifications.

## 0.1.1 (beta)

- `BuoyAsyncImage` no longer reloads forever inside a `List` row. The row's height change restarted the load, which cancelled the request each time, so the image never appeared.
- The Env tool no longer shows `BUOY_LICENSE_KEY`, so the account key from your Run scheme stays out of Buoy Desktop and MCP.
- Time Machine reports its current route and restore results in the format Buoy Desktop and MCP read. They showed "[object Object]" and "undefined" before.
- Tapping the navigation bar's back button through MCP now goes back.
- The first Events read over MCP now includes requests made since launch. It returned an empty timeline until something else had opened the Network tool.

## 0.1.0 (beta)

First public beta of the native iOS package for SwiftUI and UIKit hosts. It ships as a signed binary framework, needs iOS 16 or later and Xcode 16 or later, and works in apps that use Swift 5 or Swift 6 language mode.

- Network, Console, Storage, Env, Impersonate, Image Overlay, Images, Notifications, and Routes tools.
- Scenarios with reviewed drafts, execution outcomes, cleanup, and development-only UI recording.
- Time Machine with UserDefaults and registered MMKV snapshots, live restore, source selection, previews, and a floating restore bar with Undo.
- Events with native source filters, event details, copy formats, and persisted export settings.
- Assets with loose app resource inventory, explicit host load reporting, and baseline comparison.
- Native MCP discovery and supported actions, account admission, and capability reporting.
- UserDefaults required-reason privacy manifest inside the framework.
- `BUOY_SOCKET_URL` environment variable to point a physical device at Buoy Desktop without code changes.
- Startup warnings on a physical device when the broker URL is `localhost` or the local-network and App Transport Security entries are missing.

This version does not provide complete React Native parity. See the README for native integration requirements and platform limits.
