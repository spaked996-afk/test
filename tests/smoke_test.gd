extends SceneTree

func _initialize() -> void:
	var manifest_path := "res://addons/clearkey/manifest.json"
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(manifest_path))
	if typeof(parsed) != TYPE_DICTIONARY:
		_fail("manifest is not valid JSON")
		return
	var manifest: Dictionary = parsed
	var checked := 0
	for item in manifest["prompts"]:
		for theme in manifest["themes"]:
			for state in manifest["states"]:
				for size in manifest["scales"]:
					var file := "res://addons/clearkey/assets/%s/%s/png_%d/%s.png" % [theme, state, int(size), item["id"]]
					var image := Image.new()
					var decode_error := image.load_png_from_buffer(FileAccess.get_file_as_bytes(file))
					if decode_error != OK or image.is_empty():
						_fail("missing or corrupt: " + file)
						return
					if image.get_width() != int(size) or image.get_height() != int(size):
						_fail("wrong dimensions: " + file)
						return
					checked += 1
	var key_event := InputEventKey.new()
	key_event.physical_keycode = KEY_W
	if ClearKeyResolver.prompt_for_event(key_event) != "key_w":
		_fail("resolver failed for physical W key")
		return
	var mouse_event := InputEventMouseButton.new()
	mouse_event.button_index = MOUSE_BUTTON_LEFT
	if ClearKeyResolver.prompt_for_event(mouse_event) != "mouse_left":
		_fail("resolver failed for left mouse button")
		return
	var prompt := ClearKeyPrompt.new()
	prompt.prompt_id = "missing_test_id"
	if not prompt.tooltip_text.begins_with("Missing"):
		_fail("missing prompt state was not exposed")
		return
	prompt.prompt_id = "key_w"
	if not prompt.tooltip_text.is_empty():
		_fail("prompt tooltip did not recover after invalid-to-valid id change")
		return
	if prompt.texture == null:
		_fail("valid prompt texture was not loaded")
		return
	prompt.free()
	print("CLEARKEY_SMOKE_OK prompts=%d png_files=%d" % [int(manifest["count"]), checked])
	quit(0)

func _fail(message: String) -> void:
	push_error("CLEARKEY_SMOKE_FAIL " + message)
	quit(1)
