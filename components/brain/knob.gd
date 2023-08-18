extends Node2D

class_name Knob

signal on_value_change(float)

@export var is_in_viewport := false : set = _set_is_in_viewport

var focus: bool = false
var pressed := false
var viewport: SubViewportContainer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _procsss(delta):
	pass
	
func _set_is_in_viewport(value: bool) -> void:
	is_in_viewport = value
	if is_in_viewport:
		viewport = get_viewport().get_parent()

func _on_area_2d_mouse_entered():
	focus = true

func _on_area_2d_mouse_exited():
	focus = false

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
	
	pressed = event.is_pressed()
	
func _on_mouse_motion(event: InputEventMouseMotion) -> void:
	if is_in_viewport:
		look_at(event.position - viewport.global_position)
	else:
		look_at(event.position)
	
	emit_signal("on_value_change", value())

func value() -> int:
	# map the full circle of the dial in radians (from -PI to +PI -> 2*PI is the whole circle)
	# onto (0,1) = normalization.
	return remap(global_rotation, -PI, PI, -10, 10)
	
