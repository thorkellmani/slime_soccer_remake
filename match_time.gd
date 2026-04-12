extends Timer

func parse_time() -> String:
	if is_stopped():
		return ""
	
	var minutes = floorf(time_left / 60)
	var seconds = fmod(time_left, 60)
	var ms = fmod(seconds * 10, 10)
	
	#var format_string = "%s was reluctant to learn %s, but now he enjoys it."
	#var actual_string = format_string % ["Estragon", "GDScript"]
	
	var formatted_string: String = "%02d:%02d:%02d" % [minutes, seconds, ms]
	return formatted_string
