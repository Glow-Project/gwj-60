extends Control

signal radio_update(on: bool)


func _on_on_button_pressed() -> void:
	emit_signal("radio_update", true)

func _on_off_button_pressed() -> void:
	emit_signal("radio_update", false)
