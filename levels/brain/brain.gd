extends Node2D

class_name Brain

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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


func _on_button_pressed():
	pass
