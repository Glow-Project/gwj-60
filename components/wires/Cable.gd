extends Line2D

class_name Cable

var source: Jack = null : set = set_source
var destination: Jack = null : set = set_destination

func set_source(src: Jack):
	source = src
	modulate = src.modulate
	if points.size() == 0:
		add_point(src.position)
	else:
		set_point_position(0, src.position)

func set_destination(dst: Jack):
	destination = dst
	if points.size() == 1:
		add_point(dst.position)
	else:
		set_point_position(1, dst.position)

func update_destination(pos: Vector2) -> void:
	if points.size() == 1:
		add_point(pos)
	else:
		set_point_position(1, pos)

func is_connected_to(jack: Jack) -> bool:
	return source == jack or destination == jack

func is_fully_connected() -> bool:
	return source != null and destination != null

func validate() -> String:
	if !is_fully_connected():
		return "Cable is not fully connected"
	if source.modulate != destination.modulate:
		return "Jack color mismatch"
	
	return ""
