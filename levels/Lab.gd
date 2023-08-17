extends Node2D

var radio_display_scene := preload("res://components/displays/radio/RadioDisplay.tscn")
var test_suite_scene := preload("res://components/displays/test_suite/TestSuite.tscn")

@onready var robot_head: RobotHead = $RobotHead
@onready var minigames: Dictionary = {
	"wires": preload("res://levels/wires/wires.tscn").instantiate(),
	"logic": preload("res://levels/logicgates/logicgates.tscn").instantiate()
}

func _ready() -> void:
	boot_radio_screen()
	boot_test_suite_screen()

func boot_radio_screen() -> void:
	var radio_display = radio_display_scene.instantiate()
	radio_display.connect("radio_update", func(on: bool): $Radio.playing = on)
	$RadioScreen.child_scene = radio_display

func boot_test_suite_screen() -> void:
	var test_suite = test_suite_scene.instantiate()
	test_suite.minigames = $Minigames.get_children()
	test_suite.connect("boot_start", func(): robot_head.start_booting())
	test_suite.connect("boot_success", func(): robot_head.success_boot())
	test_suite.connect("boot_fail", func(): robot_head.fail_boot())
	$TestSuiteScreen.child_scene = test_suite


func _on_wires_minigame_selector_select() -> void:
	$MinigameViewport.minigame = minigames["wires"]

func _on_logic_minigame_select() -> void:
	$MinigameViewport.minigame = minigames["logic"]
