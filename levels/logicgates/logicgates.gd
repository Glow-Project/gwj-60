extends Node2D

@onready var target_gate: Gate = $Out

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# trigger evaluation of whole logic gates
	target_gate.output()
