@tool
extends TextureRect
class_name ClearKeyPrompt

@export var prompt_id := "key_space":
	set(value):
		prompt_id = value
		_refresh()
@export_enum("dark", "light") var display_theme := "dark":
	set(value):
		display_theme = value
		_refresh()
@export_enum("normal", "pressed") var state := "normal":
	set(value):
		state = value
		_refresh()
@export_enum("16", "32", "64", "128") var source_size: int = 128:
	set(value):
		source_size = value
		_refresh()

func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_refresh()

func set_pressed(pressed: bool) -> void:
	state = "pressed" if pressed else "normal"

func set_from_event(event: InputEvent) -> bool:
	var resolved := ClearKeyResolver.prompt_for_event(event)
	if resolved.is_empty():
		return false
	prompt_id = resolved
	return true

func set_from_action(action_name: StringName) -> bool:
	var resolved := ClearKeyResolver.prompt_for_action(action_name)
	if resolved.is_empty():
		return false
	prompt_id = resolved
	return true

func _refresh() -> void:
	var file := "res://addons/clearkey/assets/%s/%s/png_%d/%s.png" % [display_theme, state, source_size, prompt_id]
	if FileAccess.file_exists(file):
		texture = load(file)
		tooltip_text = ""
	else:
		texture = null
		tooltip_text = "Missing ClearKey prompt: %s" % file
