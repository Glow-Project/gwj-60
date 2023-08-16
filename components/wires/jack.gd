extends Sprite2D

class_name Jack

var in_use :bool = false

@onready var area: Area2D = $Shape

func highlight()-> void:
	$AnimationPlayer.play("highlight")

func unhighlight()->void:
	$AnimationPlayer.play("RESET")

func _on_shape_mouse_entered():
	in_use = true

func _on_shape_mouse_exited():
	in_use = false
