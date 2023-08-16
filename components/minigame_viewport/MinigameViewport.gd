extends SubViewportContainer

func _ready() -> void:
	set_process_input(true)
	set_process_unhandled_input(true)

func _input(event: InputEvent) -> void:
	$SubViewport.get_child(0)._input(event)
