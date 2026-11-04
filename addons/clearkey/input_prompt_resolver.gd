extends RefCounted
class_name ClearKeyResolver

static var last_device := "keyboard_mouse"

static func observe(event: InputEvent) -> String:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		last_device = "gamepad"
	elif event is InputEventKey or event is InputEventMouse:
		last_device = "keyboard_mouse"
	return last_device

static func prompt_for_action(action_name: StringName) -> String:
	if not InputMap.has_action(action_name):
		return ""
	var events := InputMap.action_get_events(action_name)
	for event in events:
		var is_gamepad := event is InputEventJoypadButton or event is InputEventJoypadMotion
		if (last_device == "gamepad") == is_gamepad:
			var result := prompt_for_event(event)
			if not result.is_empty():
				return result
	for event in events:
		var result := prompt_for_event(event)
		if not result.is_empty():
			return result
	return ""

static func prompt_for_event(event: InputEvent) -> String:
	if event is InputEventKey:
		var code: int = int(event.physical_keycode if event.physical_keycode != 0 else event.keycode)
		if code >= KEY_A and code <= KEY_Z:
			return "key_" + char(code).to_lower()
		if code >= KEY_0 and code <= KEY_9:
			return "key_" + char(code)
		var keys := {
			KEY_SPACE: "key_space", KEY_ENTER: "key_enter", KEY_ESCAPE: "key_escape",
			KEY_TAB: "key_tab", KEY_UP: "arrow_up", KEY_DOWN: "arrow_down",
			KEY_LEFT: "arrow_left", KEY_RIGHT: "arrow_right"
		}
		return keys.get(code, "")
	if event is InputEventMouseButton:
		var mouse := {
			MOUSE_BUTTON_LEFT: "mouse_left", MOUSE_BUTTON_RIGHT: "mouse_right",
			MOUSE_BUTTON_MIDDLE: "mouse_middle", MOUSE_BUTTON_WHEEL_UP: "wheel_up",
			MOUSE_BUTTON_WHEEL_DOWN: "wheel_down"
		}
		return mouse.get(event.button_index, "")
	if event is InputEventJoypadButton:
		var pad := {
			JOY_BUTTON_A: "pad_south", JOY_BUTTON_B: "pad_east", JOY_BUTTON_X: "pad_west", JOY_BUTTON_Y: "pad_north",
			JOY_BUTTON_BACK: "pad_select", JOY_BUTTON_START: "pad_start", JOY_BUTTON_LEFT_STICK: "pad_l3",
			JOY_BUTTON_RIGHT_STICK: "pad_r3", JOY_BUTTON_LEFT_SHOULDER: "pad_l1", JOY_BUTTON_RIGHT_SHOULDER: "pad_r1",
			JOY_BUTTON_DPAD_UP: "dpad_up", JOY_BUTTON_DPAD_DOWN: "dpad_down", JOY_BUTTON_DPAD_LEFT: "dpad_left", JOY_BUTTON_DPAD_RIGHT: "dpad_right"
		}
		return pad.get(event.button_index, "")
	return ""
