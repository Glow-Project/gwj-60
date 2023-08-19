extends Area2D

signal select()

@export var texture: Texture2D

var mouse_inside := false
var highlight_shader := preload("res://components/minigame_selector/Highlight.gdshader")

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.material = sprite.material.duplicate()
	sprite.texture = texture

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and mouse_inside:
		emit_signal("select")

func _on_mouse_entered() -> void:
	if not mouse_inside:
		$AudioStreamPlayer.play()
	mouse_inside = true
	sprite.material.shader = highlight_shader
	var tween = create_custom_tween()
	tween.tween_property(sprite, "position", Vector2(0, -5), .25)

func _on_mouse_exited() -> void:
	mouse_inside = false
	sprite.material.shader = null
	var tween = create_custom_tween()
	tween.tween_property(sprite, "position", Vector2.ZERO, .25) 

func create_custom_tween() -> Tween:
	return get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_SPRING)
