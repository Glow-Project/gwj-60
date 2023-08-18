extends Sprite2D

class_name Jack

var in_use: bool = false

@onready var area: Area2D = $Shape

# fix for the unhandled input in a viewport
# ask @Tch1b0 if there are questions
func _input(event: InputEvent) -> void: pass

func highlight()-> void:
	$AnimationPlayer.play("highlight")

func unhighlight()->void:
	$AnimationPlayer.play("RESET")

func _on_shape_mouse_entered():
	in_use = true

func _on_shape_mouse_exited():
	in_use = false
