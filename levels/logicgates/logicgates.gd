extends Node2D

@onready var target_gate: Gate = $Out

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	set_process_unhandled_input(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# trigger evaluation of whole logic gates
	target_gate.output()

func _input(event: InputEvent) -> void:
	for child in get_children():
		if child is Sprite2D and child != $Background:
			child._input(event)

func validate() -> String:
	return "" if $Out.output() else "no output signal" 
