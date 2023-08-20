extends Node2D

var radio_display_scene := preload("res://components/displays/radio/RadioDisplay.tscn")
var test_suite_scene := preload("res://components/displays/test_suite/TestSuite.tscn")

var radio_display: RadioDisplay
var test_suite: TestSuite

@onready var robot_head: RobotHead = $RobotHead
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var minigames: Dictionary

func _ready() -> void:
	randomize()
	boot_radio_screen()
	reload_minigames()
	var suite = boot_test_suite_screen()
	var tree := get_tree()
	
	tree.paused = true
	anim.connect("animation_finished", func(name):
		if name == "intro":
			tree.paused = false
			$Radio.play_song()
			suite.boot()
	)

func _input(event: InputEvent) -> void:
	if anim.current_animation == "pre_intro" and not (event is InputEventMouseMotion):
		$PreIntro/Label.text = "Flashing firmware..."
		anim.play("intro")

func reload_minigames() -> void:
	$MinigameViewport.minigame = null
	minigames = {
		"wires": preload("res://levels/wires/wires.tscn").instantiate(),
		"logic": preload("res://levels/logicgates/logicgates.tscn").instantiate(),
		"optics": preload("res://levels/optics/optics.tscn").instantiate(),
		"brain": preload("res://levels/brain/brain.tscn").instantiate()
	}
	minigames["logic"].name = "Logic Gates"
	minigames["optics"].name = "Laser"
	minigames["brain"].name = "Drawing"
	if test_suite:
		test_suite.minigames = minigames.values()

func boot_radio_screen() -> void:
	radio_display = radio_display_scene.instantiate()
	radio_display.connect("radio_update", func(on: bool): $Radio.playing = on)
	$RadioScreen.child_scene = radio_display

func boot_test_suite_screen():
	test_suite = test_suite_scene.instantiate()
	test_suite.minigames = minigames.values()
	test_suite.connect("boot_start", func(): robot_head.start_booting())
	test_suite.connect("boot_success", func(): 
		robot_head.success_boot()
		var tw := create_tween()
		tw.tween_property($Radio, "volume_db", -60, 1)
		await tw.finished
		get_tree().paused = true
		anim.play("outro")
		await anim.animation_finished
		get_tree().reload_current_scene()
	)
	test_suite.connect("boot_fail", func():
		robot_head.fail_boot()
		reload_minigames()
	)
	$TestSuiteScreen.child_scene = test_suite
	return test_suite


func _on_wires_minigame_selector_select() -> void:
	$MinigameViewport.minigame = minigames["wires"]

func _on_logic_minigame_select() -> void:
	$MinigameViewport.minigame = minigames["logic"]

func _on_optics_mingame_select() -> void:
	$MinigameViewport.minigame = minigames["optics"]

func _on_brain_minigame_select() -> void:
	$MinigameViewport.minigame = minigames["brain"]

func _on_radio_song_selected(song) -> void:
	radio_display.set_song(song)

func _on_tutorial_card_select() -> void:
	$MinigameViewport.minigame = null
