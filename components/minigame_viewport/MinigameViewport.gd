extends SubViewportContainer

@export var minigame: Node : set = _set_minigame

@onready var subviewport: SubViewport = $SubViewport

func _set_minigame(value) -> void:
	minigame = value
	if subviewport.get_child_count() == 1:
		subviewport.remove_child(subviewport.get_child(0))
	if minigame:
		subviewport.add_child(minigame)

func _ready() -> void:
	set_process_input(true)
	set_process_unhandled_input(true)

func _input(event: InputEvent) -> void:
	for child in $SubViewport.get_children():
		child._input(event)
