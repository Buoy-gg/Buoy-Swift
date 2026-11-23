# Changelog

## 0.1.17 (beta)

- Pushing a fake message into a socket, or sending one, no longer crashes the app on iOS 18 and older.
- Taps in a bug case now have their real time. Each tap picture sits next to its own tap.
- A part inside `buoyMask` is boxed even when it sticks out past the mask's edge.
- Signing out ends a socket Block or Freeze, so the app's messages flow again.
- A socket made with `URLSession.shared` shows as open right away. It used to wait for its first message.
- Stopping an Ask Buoy turn also stops the AI call it was waiting on.
- A hidden secret in a link shows `[hidden by Buoy]` once, not twice.
- Network now has a Sockets screen. It shows each WebSocket your app opens with `URLSessionWebSocketTask`. You see each message sent and got. You also see when a socket opens, closes or has an error.
- A reply is tied to the message that asked for it. Buoy shows how long the reply took.
- Problems turn red. A reply may never come. A socket may reconnect too much or fail to sign in again and again. It may not connect at all. Two sockets may be open at once. The app may send on a closed socket.
- Tokens and passwords in a message show as [hidden]. Buoy hides them before it keeps the message.
- Tricks (Pro) can push a fake message into your app. They can also drop, kick out, freeze or block a socket.
- The sockets list goes to Desktop and to the MCP `get_sockets` tool. `socket_action` works too.
- Bug Links cases now have pictures of the app. Each tap gets a picture too. Password fields are always boxed out. Text and images are boxed out too. So are text fields. You can turn that off. Mark your own secret parts with `buoyMask`. A case that is too big keeps fewer pictures. Cases with pictures from other phones keep them when they load here.
- Ask Buoy now uses Buoy's own AI if you set nothing up. A config with its own endpoint works the same as before.
- A hint you close now stays closed on all your devices. The list is saved on your account.
- Settings now has Hide Buoy. Hide it for 5 minutes, 1 hour, the rest of today, or until you turn it back on. Tap the top left corner five times to bring it back. Code can call `Buoy.hide()` and `Buoy.show()`.
- The Show Buoy switch on buoy.gg can hide Buoy in all your apps.
- The first-run hints have a new look. They all use one dark card with a green Got it button.
- The sign-in card has an Open buoy.gg button above the QR code.
- You can now sign out of a Buoy key on the Pro tab. The key stays off, even when the app starts again. Tap Use the Buoy key again to get it back.
- If you just paid, you get Pro sooner. When the app starts or comes back, Buoy asks buoy.gg for your plan. It asks once your sign-in is 5 minutes old.
- If you are signed in but this build needs a paid plan, the button says Plan needed. Tap it, and Buoy checks your plan right away.
- Ask Buoy no longer hides a `{{secret:NAME}}` stand-in. It holds no secret. A real password is still hidden.
- Ask Buoy can make lots of fake rows in one step. It writes one row and a count, and the app fills in the rest. Names, emails, dates and more look real.
- `{{image:1200x400}}` makes a test picture of that exact size on the phone. Each row gets its own color and number.
- New rows can be added to a list with `$append`. They copy the fields they leave out from a real row.
- When every step works, Ask Buoy can stop after one round. You wait less.
- Apps can give Ask Buoy mock recipes with `defineMocks`, `apiListRecipe` and `failRecipe`. A plain ask like "add 40 friends" or `/mock friends 40` runs on the phone with no AI call.
- A recipe can name its screen. Then it only runs while that screen is open.
- A recipe can make web calls fail. They can fail every time, every other time, or once and then work.
- A Network rule can now fail each call once and let its retry through (`firstTry`).
- Mock rows end when the app restarts, so a bad row can't break every launch. The chat says the mock data was cleared.
- A recipe can add rows to a list the app has not loaded yet. The rows show up the first time it loads.
- Plain asks run with no AI call. Some are "go offline", "back online", "undo that" and "tap the Privacy tab".
- Apps can give each screen a note with `ContextPack.screens`. Ask Buoy picks screens by their notes.
- "503 on the store api" now makes that error happen. A question about an error only reads.
- In a release build, Ask Buoy asks before it taps. A card for typing into a field never shows the text.

## 0.1.16 (beta)

- Tokens, cookies and keys are now hidden before they leave the app. Buoy Desktop shows `[hidden by Buoy]` in their place.
- In a debug build, click Secrets hidden in Buoy Desktop to see the real values. A release build always hides them.
- Bug Links can now only be pointed at buoy.gg, your app's server or a local dev server.

## 0.1.15 (beta)

- In a release build, the header that acts as another user now needs a paid plan and the Buoy menu on screen.
- A bug report keeps each saved value's type, even when its name sounds secret. Before, a report like that could fail to load.

## 0.1.14 (beta)

- A loaded bug's block no longer stops Buoy's own sign-in. Before, the pill said to sign in, but that sign-in could fail.
- The FAKE NETWORK pill now builds on Xcode 16.

## 0.1.13 (beta)

- Scenarios, Network rules, slow or offline modes and bug loading now work in release builds. That means ad hoc, TestFlight and App Store builds. They need a paid plan and the Buoy menu on screen.
- An amber FAKE NETWORK pill shows while a rule or a speed setting is on. Press and hold it to stop.
- With no paid plan or no menu, saved rules and scenarios do nothing.
- If your plan or sign-in ends while a bug is loaded, the recorded replies stop. Every web call stays blocked, so the bug's data can't reach real servers. A pill says so. Sign in to fix it, or hold the pill two times to use real calls. If no one does, the block ends by itself after 24 hours.
- Record a flow still needs a dev build.

## 0.1.12 (beta)

- New tool: Bug Links. Tap the bug button once. Buoy saves the app's state, web calls, logs and taps. It copies a link to the bug. A teammate opens the link and sees the same bug.
- Bugs are locked on the phone. Buoy keeps your team's key, so signing in just works. Buoy never opens a bug unless your team asks.
- The team bug list shows your team's bugs in the app. Tap Load to open one in your dev build.
- If Ask Buoy's first model fails, the backup model now gets the same question. Before, the server turned it away as a repeat.

## 0.1.11 (beta)

- Ask Buoy matches the newest React Native engine. Undo a fake web reply, and the screen loads fresh data. Undo All says how many steps it undid. A broken tool call from the AI gets fixed when it can.
- Ask Buoy pick lists work like React Native. A long list shows every choice. The count of more choices only counts the ones that match your search.
- If Ask Buoy is turned down, or runs out of steps, the chat ends with an error card. A dropped connection is tried once more.
- A tap that finds nothing now fails out loud.
- A phone set up from another phone's backup now gets its own device ID. Before, it kept the old phone's ID, so the two phones counted as one device. App updates keep the same ID.
- `BuoyAsyncImage` shows an image at full size again. A small placeholder had made it small and blurry. In a set frame, it still loads at the frame's size, like React Native.
- Env hides every Buoy key name, from every place, `Info.plist` too.
- Events export filters first, then cuts to the limit.
- The data explorer shows every child now.
- Jank labels use the same 66% line as the counts.
- Network Clear works while capture is off. Before, the old rows stayed on screen.
- The Routes tree matches React Native. Catch-all routes sort last.
- Time Machine wipes leave switched-off sources alone. Snapshots are saved before old ones are deleted.
- Team admins can hide Memory Leaks and OTA Updates.

## 0.1.10 (beta)

- `Buoy.start` now adds the Buoy overlay by itself. You don't need `.buoyDevTools()` anymore. Use it only to set options. Set `headless = true` to show no Buoy UI.
- Leave `licenseKey` out, and Buoy reads `BUOY_LICENSE_KEY` from your Run scheme. Your code names no key. `buoy login` sets it up for you.
- The sign-in card now says to run your app again from Xcode.
- You can share a scenario with your team. Open one saved on your phone. Tap Share with team. Your team sees it in Scenarios in the same app. It is marked Team.
- A team scenario can't be changed in the app. Make an editable copy to change it.
- The person who shared it can take it off the team. So can a team admin.
- Refresh gets the team's list again. Buoy keeps a copy, so the list still shows when you are offline.
- You need to sign in, or use a `buoy login` token, on a Business team. Bot keys and plain keys get no team list.
- Undo still works if a teammate changes or removes a scenario while it is on.

## 0.1.9 (beta)

- Team roles. A team admin picks the tools each role sees, on the Team page at buoy.gg. Your menu then shows only those Buoy tools. Your app's own tools always show. A role with no list sees every tool.
- A tool that is open closes when your role hides it.
- If your role has no tools, the dial says so. Settings shows your role.
- Help text now gives the full sign-in command, `npx --package=@buoy-gg/core buoy login`. The short `npx buoy login` ran a package that isn't ours.
- Ask Buoy no longer calls your app "a React Native app" when it doesn't know the app's name.

## 0.1.8 (beta)

- Routes works in UIKit apps with no setup. Buoy reads the screens from your view controllers: the tab you're on, its navigation stack and anything shown on top. `ArticleViewController` shows up as `/article`, with its title as a param. Going back works too. Events and Time Machine get the screen as well. Your own `BuoyRoutes.configure` or `.buoyRoute` still wins. Turn it off with `BuoyRoutes.trackUIKitScreens = false`.
- A tool's panel saves its size and spot as soon as it opens, like React Native. Before, it saved only after you dragged or resized it.
- An undo from Buoy Desktop or MCP now stays done after a restart. So does an undo in the tool itself. Before, Ask Buoy said those changes were not undone.

## 0.1.7 (beta)

We ran Buoy in the Wikipedia and Mastodon apps. These fixes came from that.

- Ask Buoy's second message with Claude no longer fails. It sent back Claude's notes from the last message, and Claude said no. Now it sends only this message's notes, like React Native.
- An app with no key now shows "Sign in". It used to say "Checking…" and never stop.
- The daily ping keeps its id in Buoy's own files, like React Native. Your app's storage list no longer shows it. An id from 0.1.6 moves over once.
- Over MCP, one web call now shows its method, its link and its status. It also says when an override sent the answer.
- AI agents can open the Buoy menu and Settings by name. So can VoiceOver.
- Agents can tap Buoy's own Settings and its first card while the dial is open.

## 0.1.6 (beta)

Every Swift tool but Sentry now works like React Native. We ran React Native's own tool tests on the Swift app, and all 1,048 pass. Tests that need JavaScript are skipped. That covers Redux, Zustand, Jotai, React Query, JS Top and Three.

- Your Buoy data is now saved where React Native saves it, in the same shape. That covers tool settings, Time Machine, Events, Routes, Scenarios and the license cache. Old saves move over once.
- The license remembers its last answer. When the server says to wait, it waits. Times in it round down, like JavaScript. A free account no longer looks locked for a moment.
- New floating tools: `openFloatingTool`, `dismissFloatingTool`, `registerPersistentFloatingTool` and `BuoyFloatingTool`. They work like React Native's.
- New `NetworkConditionsControl` view. It sets slow or offline web calls, like React Native's.
- New Clock timers: `BuoyClock.after`, `BuoyClock.every` and `BuoyClock.sleep`. They follow the Clock tool when you jump the time.
- Storage logs each UserDefaults write as its own event, even a write that repeats a value. A typed edit saves after 300 ms. Pins use the key name. Buoy's own keys stay out of the list.
- Events shows only what happened after it started. Web calls from before then count as old. Clear works. The list keeps 200 events. The render source starts off, like React Native.
- Time Machine keeps one file per snapshot, like React Native. It can save Keychain items. Its bar opens with a tap, so a drag can't hide it.
- Routes reads `/user/[id]` as dynamic. Names look like Expo's, such as `route-bench/[step]`. Only repeated route events fold together. The list holds still while paused.
- Scenarios has React Native's 14 demo scenarios. The recorder now plays back long presses, switches and sliders.
- Location uses the Permissions tool's answer. A one-time read works while a watch runs. Fences draw on top of places on the map.
- Notifications read the reply text a user types. They see the tap that opened the app. A banner no longer shows unless you asked for one.
- Assets: `UIImage(named:)` marks its file as loaded on its own. For SwiftUI's `Image("name")`, still call `markLoaded`.
- Images keeps one record per view, sized like the view.
- Impersonate: wipe and sign out work like React Native. A bad pattern no longer breaks it.
- Console shows Buoy's own logs and keeps logs when Preserve is on.
- Bench no longer shows a Reanimated row. Swift has no worklet thread.
- Debug Borders finds SwiftUI ids. Highlight now shows the "state" and "parent" reasons for a draw.
- Ask Buoy's sheet springs back 2.5 s after it drops, like React Native.
- Every press style takes taps across its whole row.

These two came out in 0.1.5 but were left out of its notes:

- Buoy sends a small, anonymous ping once a day. It only runs in dev builds, never in an app you ship. It holds a random id, the Buoy version, the platform, your plan and "swift". It holds no app or tool data. Turn it off with `config.telemetry = false`. Read more at buoy.gg/buoy/latest/docs/telemetry.
- A Pro app no longer shows as free for a few seconds after it starts. A sign-in let the app in before its Pro key was checked. In that gap, the app told Buoy it was free. AI agents then got "needs Buoy Pro" and stopped. Now the app waits for its key before it says free. A Pro answer still goes out right away.

## 0.1.5 (beta)

- Hosted Ask Buoy now answers with Claude Haiku 5.5 first. GPT-6 Luna is its backup.
- If Claude is down, Luna answers on its own. The other way round works too. If both are down, Ask Buoy says so: "Ask Buoy is down right now. We know, and we're working on it."
- Pick your model in Ask Buoy's settings. You can also pick it on buoy.gg, on the Ask Buoy tab. Your pick syncs between the two. It starts with your next new chat.
- The credits line now says about how many asks you have left.
- The one-time note now says where your question goes: Anthropic for Claude, or OpenAI for Luna.

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

First public beta of the native iOS package for SwiftUI and UIKit hosts, with iOS 16 as the minimum deployment target and Swift 6 language mode.

- Network, Console, Storage, Env, Impersonate, Image Overlay, Images, Notifications, and Routes tools.
- Scenarios with reviewed drafts, execution outcomes, cleanup, and development-only UI recording.
- Time Machine with UserDefaults and registered MMKV snapshots, live restore, source selection, previews, and a floating restore bar with Undo.
- Events with native source filters, event details, copy formats, and persisted export settings.
- Assets with loose app resource inventory, explicit host load reporting, and baseline comparison.
- Native MCP discovery and supported actions, account admission, and capability reporting.
- UserDefaults required-reason privacy manifest in the shared UI resource bundle.
- `BUOY_SOCKET_URL` environment variable to point a physical device at Buoy Desktop without code changes.
- Startup warnings on a physical device when the broker URL is `localhost` or the local-network and App Transport Security entries are missing.

This version does not provide complete React Native parity. See the README for native integration requirements and platform limits.
