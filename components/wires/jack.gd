extends Sprite2D

class_name Jack

var in_use :bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func highlight()-> void:
	$AnimationPlayer.play("highlight")

func unhighlight()->void:
	$AnimationPlayer.play("RESET")

func _on_shape_mouse_entered():
	in_use = true

func _on_shape_mouse_exited():
	in_use = false
