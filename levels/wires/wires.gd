extends Node2D

var source :Jack = null
var destination :Jack = null

var current_line :Line2D

var pressed :bool = false

var cable_prototype :PackedScene = preload("res://components/wires/Cable.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	# motion handler for dragging
	if event is InputEventMouseMotion:
		if current_line == null:
			return
		
		if current_line.points.size() == 1:
			current_line.add_point(event.position)
		else:
			current_line.set_point_position(1, event.position)
		return
	
	if not event is InputEventMouseButton:
		return
	
	event = event as InputEventMouseButton
	
	if event.button_index == MOUSE_BUTTON_RIGHT and pressed:
		var selected_jack :Jack = null
		for n in $Jacks.get_children():
			n = n as Jack
			if n.in_use:
				selected_jack = n
				break
		if selected_jack == null:
			return
		
		# find cable connected to the selected jack and remove it
		var cable :Cable = find_cable(selected_jack)
		if cable != null:
			print_debug("remove cable")
			remove_child(cable)
			
	
	# only right-click
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	# avoid event burst
	if pressed == event.is_pressed():
		return
		
	var selected_jack :Jack = null
	for n in $Jacks.get_children():
		n = n as Jack
		if n.in_use:
			selected_jack = n
			break
	
	# remove previous cables (if any)
	var previous_cable :Cable = find_cable(selected_jack)
	if previous_cable != null and previous_cable.is_fully_connected():
		print_debug("remove cable")
		remove_child(previous_cable)
	
	# skip user clicked outside of the jacks
	if selected_jack == null:
		return
		
	if event.is_pressed():
		source = selected_jack
		source.highlight()
		current_line = cable_prototype.instantiate()
		current_line.set_source(source)
		print_debug("add cable")
		add_child(current_line)
	elif source != null:
		if selected_jack != source:
			current_line.set_destination(selected_jack)
		current_line = null
		source.unhighlight()
		source = null		
	else:
		# skip case where player clicked outside of the jack
		# but released the button on a jack. Otherwise the
		# source would be null while the destination would be set
		return 
		
	pressed = event.is_pressed()

func find_cable(jack :Jack) -> Cable:
	for node in get_children():
		if node is Cable:
			node = node as Cable
			if node.is_connected_to(jack):
				return node
	return null
