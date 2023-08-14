extends Node2D

var drag :Jack = null
var drop :Jack = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in $In.get_children():
		n = n as Jack
		n.OnDrag.connect(_on_drag)
		n.OnDrop.connect(_on_drop)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_drag(node: Jack):
	drag = node
	
func _on_drop(node: Jack):
	if node == drag:
		drag = null
		drop = null
		return
