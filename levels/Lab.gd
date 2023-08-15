extends Node2D

var radio_display_scene := preload("res://components/displays/radio/RadioDisplay.tscn")

func _ready() -> void:
	boot_radio_screen()

func boot_radio_screen() -> void:
	var radio_display = radio_display_scene.instantiate()
	radio_display.connect("radio_update", func(on: bool): $Radio.playing = on)
	$RadioScreen.child_scene = radio_display
