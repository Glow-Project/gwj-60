extends Node2D

@export var is_in_viewport := true : set = _set_is_in_viewport

var focus: bool = false
var pressed := false : set = _set_pressed
var start: Vector2
var highlight_shader = preload("res://components/minigame_selector/Highlight.gdshader")
var viewport: SubViewportContainer = null

@onready var sprite: Sprite2D = $Sprite2D

func _set_is_in_viewport(value: bool) -> void:
	is_in_viewport = value
	if is_in_viewport:
		viewport = get_viewport().get_parent()

func _set_pressed(value: bool) -> void:
	pressed = value
	sprite.material.shader = highlight_shader if pressed else null

func _ready() -> void:
	sprite.material = sprite.material.duplicate()

func _input(event: InputEvent) -> void:
	if (focus || pressed) and event is InputEventMouseButton:
		_on_mouse_button(event)
	elif pressed and event is InputEventMouseMotion:
		_on_mouse_motion(event)

func _on_mouse_button(event: InputEventMouseButton) -> void:
	if event.button_index != MOUSE_BUTTON_LEFT:
		return	
	
	# avoid event burst
	if pressed and event.is_pressed():
		return
	
	if event.is_pressed():
		start = event.global_position
	pressed = event.is_pressed()
	
func _on_mouse_motion(event: InputEventMouseMotion) -> void:
	if is_in_viewport:
		look_at(event.position - viewport.global_position)
	else:
		look_at(event.position)

func _on_area_2d_mouse_entered():
	focus = true

func _on_area_2d_mouse_exited():
	focus = false
