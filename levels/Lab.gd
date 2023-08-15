extends Node2D

var radio_display_scene := preload("res://components/displays/radio/RadioDisplay.tscn")

func _ready() -> void:
	$Sprite2D/RadioScreen.child_scene = radio_display_scene.instantiate()
