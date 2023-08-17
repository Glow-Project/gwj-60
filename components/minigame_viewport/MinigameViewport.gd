extends SubViewportContainer

@export var minigame: Node : set = _set_minigame

@onready var subviewport: SubViewport = $SubViewport

func _set_minigame(value) -> void:
	minigame = value
	if subviewport.get_child_count() == 1:
		subviewport.remove_child(subviewport.get_child(0))
	subviewport.add_child(minigame)

func _ready() -> void:
	$SubViewport.add_child(minigame)
	set_process_input(true)
	set_process_unhandled_input(true)
