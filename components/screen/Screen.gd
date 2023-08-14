extends Node2D

@export var child_scene: Node = null : set = _set_child_scene

func _set_child_scene(value) -> void:
	child_scene = value
	$SubViewportContainer.add_child(child_scene)
