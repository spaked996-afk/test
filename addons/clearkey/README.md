# ClearKey Input Prompts

Add `ClearKeyPrompt` to a scene and set `prompt_id`, `display_theme`, `state`, and `source_size` in the Inspector. All IDs are listed in `manifest.json`.

Call `set_from_event(event)` or `set_from_action(&"ui_accept")` to resolve a Godot input binding. Feed gameplay events to `ClearKeyResolver.observe(event)` when action prompts should prefer the last active device.

The node uses nearest-neighbor filtering. Use integer multiples of 16 px for crisp results.

No network requests, telemetry, editor icons, console logos, or third-party visual assets are included. See the license file(s) in this folder for the code and visual assets installed with the addon.
