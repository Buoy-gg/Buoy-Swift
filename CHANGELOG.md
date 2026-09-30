# Changelog

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
