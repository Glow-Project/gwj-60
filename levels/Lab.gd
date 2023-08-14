extends Node2D

var radio_display_scene := preload("res://components/displays/radio/RadioDisplay.tscn")

func _ready() -> void:
	var radio_display = radio_display_scene.instantiate()
	$Sprite2D/RadioScreen.child_scene = radio_display
