extends Control

const BG := Color("101827")
const PANEL := Color("1e2b3e")
const TEXT := Color("f5f9fc")
const MUTED := Color("91a4bd")

var manifest: Dictionary
var grid: GridContainer
var theme_name := "dark"
var state_name := "normal"

func _ready() -> void:
	RenderingServer.set_default_clear_color(BG)
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string("res://addons/clearkey/manifest.json"))
	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("ClearKey manifest could not be loaded")
		return
	manifest = parsed
	_build_ui()
	_populate()

func _build_ui() -> void:
	var root := VBoxContainer.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT, Control.PRESET_MODE_MINSIZE, 24)
	root.add_theme_constant_override("separation", 14)
	add_child(root)

	var title := Label.new()
	title.text = "CLEARKEY  •  INPUT PROMPTS"
	title.add_theme_font_size_override("font_size", 26)
	title.add_theme_color_override("font_color", TEXT)
	root.add_child(title)

	var info := Label.new()
	info.text = "%d prompts  •  keyboard + mouse + neutral gamepad  •  SVG + PNG 16/32/64/128" % int(manifest["count"])
	info.add_theme_color_override("font_color", MUTED)
	root.add_child(info)

	var controls := HBoxContainer.new()
	controls.add_theme_constant_override("separation", 12)
	root.add_child(controls)
	for value in ["dark", "light"]:
		var button := Button.new()
		button.text = value.capitalize() + " theme"
		button.pressed.connect(func(): theme_name = value; _populate())
		controls.add_child(button)
	for value in ["normal", "pressed"]:
		var button := Button.new()
		button.text = value.capitalize()
		button.pressed.connect(func(): state_name = value; _populate())
		controls.add_child(button)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	root.add_child(scroll)
	grid = GridContainer.new()
	grid.columns = 12
	grid.add_theme_constant_override("h_separation", 12)
	grid.add_theme_constant_override("v_separation", 12)
	scroll.add_child(grid)

func _populate() -> void:
	for child in grid.get_children():
		child.queue_free()
	for item in manifest["prompts"]:
		var icon := ClearKeyPrompt.new()
		icon.prompt_id = item["id"]
		icon.display_theme = theme_name
		icon.state = state_name
		icon.source_size = 128
		icon.custom_minimum_size = Vector2(56, 56)
		icon.tooltip_text = item["id"]
		grid.add_child(icon)
