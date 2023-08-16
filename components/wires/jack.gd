extends Sprite2D

class_name Jack

var in_use :bool = false

func highlight()-> void:
	$AnimationPlayer.play("highlight")

func unhighlight()->void:
	$AnimationPlayer.play("RESET")

func _on_shape_mouse_entered():
	print("Never gonna")
	in_use = true

func _on_shape_mouse_exited():
	in_use = false
