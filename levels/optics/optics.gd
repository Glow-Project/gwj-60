extends Node2D

@onready var ray = $Ray
@onready var caster = $RayCast2D
@onready var collision1 = $StaticBody2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ray.clear_points()
	ray.add_point($Emitter.global_position)
	
	caster.global_position = $Emitter.global_position
	caster.target_position = Vector2(100,0)
	$RayCast2D.force_raycast_update()
	
	ray.add_point($RayCast2D.get_collision_point())
	
	var reflect_target = ($RayCast2D.get_collision_point() - $RayCast2D.global_position).bounce($RayCast2D.get_collision_normal())
	$RayCast2D.global_position = $RayCast2D.get_collision_point()
	$RayCast2D.target_position = reflect_target*100
	ray.add_point($RayCast2D.global_position)
	
	$StaticBody2D/CollisionShape2D.rotate(0.01)
