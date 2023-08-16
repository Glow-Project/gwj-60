extends SubViewport

func _ready() -> void:
	set_process_input(true)
	set_process_unhandled_input(true)

func _input(event: InputEvent) -> void:
	print("Give you u")
	print(event)

func _unhandled_input(event: InputEvent) -> void:
	print("up ")
	print(event)
