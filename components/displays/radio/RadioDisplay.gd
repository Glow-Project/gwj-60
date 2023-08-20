extends Control
class_name RadioDisplay

signal radio_update(on: bool)


func _on_on_button_pressed() -> void:
	emit_signal("radio_update", true)

func _on_off_button_pressed() -> void:
	emit_signal("radio_update", false)

func set_song(song: Dictionary) -> void:
	%Label.text = "%s\n\nby\n\n%s" % [song["name"], song["artist"]]
