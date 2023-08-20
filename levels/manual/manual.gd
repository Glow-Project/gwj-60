extends Node2D

class_name Manual

@export var is_in_viewport := true : set = _set_is_in_viewport

var viewport: SubViewportContainer = null

func _set_is_in_viewport(value: bool) -> void:
	is_in_viewport = value
	if is_in_viewport:
		viewport = get_viewport().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
