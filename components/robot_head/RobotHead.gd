extends Node2D
class_name RobotHead

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: GPUParticles2D = $GPUParticles2D

func start_booting() -> void:
	anim.play("booting")

func success_boot() -> void:
	anim.stop()
	sprite.play("green")

func fail_boot() -> void:
	anim.play("crazy")
	await get_tree().create_timer(5).timeout
	anim.play("short_circuit")
