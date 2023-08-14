extends Sprite2D

class_name Jack

signal OnDrag(Node)
signal OnDrop(Node)

# Called when the node enters the scene tree for the first time.
func _ready():
	highlight()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if not event is InputEventMouseButton:
		return
		
	var mouseEvent :InputEventMouseButton = event
	
	if mouseEvent.is_released():
		emit_signal("OnDrop", self)
	elif mouseEvent.is_pressed():
		emit_signal("OnDrag", self)

func highlight()-> void:
	$AnimationPlayer.play("highlight")

func unhighlight()->void:
	$AnimationPlayer.play("RESET")
