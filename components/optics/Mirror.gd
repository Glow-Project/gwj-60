extends Sprite2D

var focus: bool = false
var pressed: bool = false
var start: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
	var y_length = event.global_position.y - start.y
	
	# scale down radian angle by a lot to slow down the movement to
	# make it precisious
	rotate(y_length/5000)

func _on_area_2d_mouse_entered():
	focus = true

func _on_area_2d_mouse_exited():
	focus = false
