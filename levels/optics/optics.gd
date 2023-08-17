extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LaserBeam.clear_points()
	$LaserBeam.add_point($Emitter.global_position)
	
	$RayCast.global_position = $Emitter.global_position
	$RayCast.target_position = Vector2(300,0)
	
	var reflect_target: Vector2
	while true:
		$RayCast.force_raycast_update()
		if !$RayCast.is_colliding():
			$LightSink.unhighlight()
			$LaserBeam.add_point($RayCast.global_position + $RayCast.target_position)
			return
		
		$LaserBeam.add_point($RayCast.get_collision_point())
	
		if $RayCast.get_collider() == $LightSink/Area2D:
			$LightSink.highlight()
			return
		
		reflect_target = (
			$RayCast.get_collision_point() - $RayCast.global_position
			).bounce($RayCast.get_collision_normal())
		$RayCast.global_position = $RayCast.get_collision_point() + reflect_target.normalized()*2
		$RayCast.target_position = reflect_target.normalized()*300
