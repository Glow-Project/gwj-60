extends Node2D
class_name Brain

# https://imgflip.com/i/7w9brq
@export var is_in_viewport := true : set = _set_is_in_viewport

var point_index: int = 0
var last_update: float = 0

var viewport: SubViewportContainer = null

func _set_is_in_viewport(value: bool) -> void:
	for child in get_children():
		print(child.name)
		if child.name.contains("Knob"):
			child.is_in_viewport = value

func _ready() -> void:
	_set_is_in_viewport(is_in_viewport)

func _input(event: InputEvent) -> void:
	for child in get_children():
		if child.name.contains("Knob"):
			child._input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if last_update + delta < 0.1:
		last_update += delta
		return
	
	last_update = 0
	
	if point_index >= $RobotLine.points.size()-2:
		point_index = 0
	
	if $RobotLine.get_point_count() > 0:
		$ShowLine.add_point($RobotLine.get_point_position(point_index))
		$ShowLine.add_point($RobotLine.get_point_position(point_index+1))
	
	for n in max(0,$ShowLine.points.size()-5):
		$ShowLine.remove_point(0)
	
	point_index += 1

func update_robot_line():
	$RobotLine.clear_points()
	
	var index: int = 0
	for point in $GoalLine.points:
		point = point as Vector2
		var robotPoint = point.rotated(
				float( $KnobA.value()) / 50
			) * 0.5 * float($KnobB.value())
		
		if index % 2 == 0:
			robotPoint += Vector2($KnobC.value() + 0.3, $KnobC.value() + 0.2)
		else:
			robotPoint -= Vector2($KnobC.value() - 0.3, $KnobC.value() - 0.2)
		
		$RobotLine.add_point(robotPoint)
		index += 1
	

func _on_knob_a_on_value_change(int):
	update_robot_line()

func _on_knob_b_on_value_change(int):
	update_robot_line()

func _on_knob_c_on_value_change(int):
	update_robot_line()

func _on_knob_d_on_value_change(value: int):
	$RobotLine.default_color.a = float(value+10)/50

func validate() -> String:
	var player: Line2D = $RobotLine
	var goal: Line2D = $GoalLine
	
	for i in range(0, player.get_point_count()):
		var p_pos := player.get_point_position(i)
		var g_pos := goal.get_point_position(i)
		if p_pos.distance_to(g_pos) > 0.5:
			return "image not aligned"
	return ""
