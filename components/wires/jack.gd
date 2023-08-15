extends Sprite2D

class_name Jack

signal OnDrag(Node)
signal OnDrop(Node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if not event is InputEventMouseButton:
		return
		
	var mouseEvent :InputEventMouseButton = event
	
	if mouseEvent.button_index != MOUSE_BUTTON_LEFT:
		return
	
	if mouseEvent.is_released():
		print_debug("drop "+ self.name)
		highlight()
		emit_signal("OnDrop", self)
	elif mouseEvent.is_pressed():
		print_debug("drag " + self.name)
		unhighlight()
		emit_signal("OnDrag", self)

func highlight()-> void:
	$AnimationPlayer.play("highlight")

func unhighlight()->void:
	$AnimationPlayer.play("RESET")
