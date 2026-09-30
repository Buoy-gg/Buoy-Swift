# Changelog

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
