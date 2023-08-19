extends Node2D
class_name Brain

# https://imgflip.com/i/7w9brq
@export var is_in_viewport := true

var point_index: int = 0
var last_update: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	for child in get_children():
		if child.name.contains("Knob"):
			child._input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if last_update + delta < 0.01:
		last_update += delta
		return
	
	last_update = 0
	
	if point_index >= $RobotLine.points.size()-2:
		point_index = 0
	
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
				float($KnobA.value())/50
			) * .5*float($KnobB.value())
		
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
