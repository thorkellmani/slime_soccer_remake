extends HBoxContainer

signal length_picked(minutes: int)

func _on_min_1_pressed() -> void:
	length_picked.emit(60)

func _on_min_2_pressed() -> void:
	length_picked.emit(60 * 2)

func _on_min_4_pressed() -> void:
	length_picked.emit(60 * 4)

func _on_min_8_pressed() -> void:
	length_picked.emit(60 * 8)
