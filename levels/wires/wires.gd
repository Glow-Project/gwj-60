extends Node2D

@export var is_in_viewport := true

var source: Jack = null
var destination: Jack = null

var current_cable: Cable

var pressed := false

var cable_prototype: PackedScene = preload("res://components/wires/Cable.tscn")

@onready var viewport: SubViewportContainer = get_viewport().get_parent() if is_in_viewport else null

# Called when the node enters the scene tree for the first time.
func _ready():
	var taken :Array
	for node in $Jacks.get_children():
		node = node as Jack
		
		while true:
			var x_offset = randi_range(
				$JackBoundary.position.x - $JackBoundary.shape.get_rect().size.x/2,
				$JackBoundary.position.x + $JackBoundary.shape.get_rect().size.x/2
			)
			var y_offset = randi_range(
				$JackBoundary.position.y - $JackBoundary.shape.get_rect().size.y/2,
				$JackBoundary.position.y + $JackBoundary.shape.get_rect().size.y/2
			)
			
			var new_position = Vector2(x_offset - x_offset % 20,y_offset - y_offset % 20)
			if not new_position in taken:
				node.position = new_position
				taken.append(new_position)
				break

func _input(event):
	match event.get_class():
		"InputEventMouseMotion":
			on_mouse_move(event)
		"InputEventMouseButton":
			on_mouse_click(event)

func on_mouse_move(event: InputEventMouseMotion) -> void:
	if current_cable != null:
		if is_in_viewport:
			current_cable.update_destination(event.position - viewport.position)
		else:
			current_cable.update_destination(event.position)

func on_mouse_click(event: InputEventMouseButton) -> void:
	# if no jack got selected, we have nothing to do
	var selected_jack: Jack = find_jack_in_use()
	if selected_jack == null:
		return
	
	if event.button_index == MOUSE_BUTTON_RIGHT and pressed:
		# find cable connected to the selected jack and remove it
		var cable: Cable = find_cable(selected_jack)
		if cable != null:
			$Cables.remove_child(cable)
	
	# only right-click
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	# avoid event burst
	if pressed == event.is_pressed():
		return
		
	# remove previous cables (if any)
	var previous_cable: Cable = find_cable(selected_jack)
	if previous_cable != null and previous_cable.is_fully_connected():
		$Cables.remove_child(previous_cable)
	
	if event.is_pressed():
		source = selected_jack
		source.highlight()
		
		# create new cable, one end connected to the source
		# and the other connected to the mouse pointer
		current_cable = cable_prototype.instantiate()
		current_cable.source = source
		$Cables.add_child(current_cable)
	else:
		if selected_jack != source:
			current_cable.destination = selected_jack
		current_cable = null
		source.unhighlight()
		source = null
		
	pressed = event.is_pressed()

func find_cable(jack: Jack) -> Cable:
	for node in $Cables.get_children():
		node = node as Cable
		if node.is_connected_to(jack):
			return node
	return null

func find_jack_in_use() -> Jack:
	for node in $Jacks.get_children():
		node = node as Jack
		if node.in_use:
			return node
	return null

func validate() -> String:
	var children := $Cables.get_children()
	if len(children) != $Jacks.get_child_count() / 2:
		return "not all wires connected"
	for cable in children:
		if cable.source.modulate != cable.destination.modulate:
			return "wrong connection"
	return ""
