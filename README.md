# ClearKey Input Prompts 1.1

Readable 16×16 input prompts for Godot 4 and any engine that accepts PNG or SVG.

## What's inside

- Keyboard, mouse, and brand-neutral gamepad prompts.
- Dark and light themes.
- Normal and pressed states.
- SVG source plus transparent PNG at 16, 32, 64, and 128 px.
- `ClearKeyPrompt` Godot node with inspector controls.
- Searchable `manifest.json` and a runnable demo scene.

This archive contains **20 prompts**. The complete pack contains 92; the free sampler contains 20.

## Install in Godot

1. Copy `addons/clearkey` into your Godot 4 project.
2. Open **Project → Project Settings → Plugins** and enable **ClearKey Input Prompts**.
3. Add a `ClearKeyPrompt` node, then choose `prompt_id`, theme, state, and source size in the Inspector.

You can also use the PNG/SVG files directly without enabling the plugin.

## Run this demo

Import this folder in Godot 4 and press **F6** or run `demo/demo.tscn`.

## Runtime example

```gdscript
$Prompt.prompt_id = "key_space"
$Prompt.display_theme = "dark"
$Prompt.set_pressed(true)
$Prompt.set_from_action(&"ui_accept")
```

## Naming

All available IDs are listed in `addons/clearkey/manifest.json`. Gamepad prompts use positions (`pad_south`, `pad_east`, and so on), not console brands, so remapping remains accurate and trademark-neutral.

## Pixel-perfect use

The node uses nearest-neighbor filtering. Display at integer multiples of 16 px for the crispest result.

## AI disclosure

OpenAI Codex assisted the icon design, geometry-generation code, product code, documentation, and research. Final PNG/SVG files were deterministically rendered by that code and manually inspected. No diffusion/text-to-image model, copied game assets, console logos, or third-party icon sets were used.

## License

The entire free sampler is MIT-licensed; see `LICENSE.md`.

## Support scope

Tested with Godot 4.4.1 and 4.7.2. The files are engine-agnostic; only the optional helper node depends on Godot.
