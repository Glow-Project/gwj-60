extends Sprite2D

class_name Gate

enum GateTypeEnum { ZERO=0, ONE, AND, OR, NOT, OUT, IN}
@export var type: GateTypeEnum = GateTypeEnum.AND

var type_textures = [
	preload("res://assets/visual/gate_zero.png"),
	preload("res://assets/visual/gate_one.png"),
	preload("res://assets/visual/gate_and.png"),
	preload("res://assets/visual/gate_or.png"),
	preload("res://assets/visual/gate_not.png"),
	preload("res://assets/visual/gate_zero.png"),
	preload("res://assets/visual/gate_one.png")
]

var highlight_shader := preload("res://components/minigame_selector/Highlight.gdshader")

@export var input1: GateConnection : set = set_input1
@export var input2: GateConnection : set = set_input2

var input_value: bool = false

var focus: bool = false
var out_audio_played: bool = false

var pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = type_textures[type]
	material = material.duplicate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if !is_active_gate() or !is_interactive_gate() or !focus:
		return
	
	if not event is InputEventMouseButton:
		return
	
	event = event as InputEventMouseButton
	
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	# avoid event bursts
	if event.is_pressed() == pressed:
		return
	elif event.is_pressed():
		$SwitchAudio.play()
		input_value = !input_value
		update_texture(input_value)
	
	pressed = event.is_pressed()

func _on_area_2d_mouse_entered():
	focus = true
	if type == GateTypeEnum.IN:
		material.shader = highlight_shader

func _on_area_2d_mouse_exited():
	focus = false
	if type == GateTypeEnum.IN:
		material.shader = null

func set_input1(latch: GateConnection) -> void:
	input1 = latch

func set_input2(latch: GateConnection) -> void:
	input2 = latch

func is_active_gate() -> bool:
	return type == GateTypeEnum.IN || type == GateTypeEnum.OUT

func is_interactive_gate() -> bool:
	return type == GateTypeEnum.IN

func update_texture(input: bool) -> void:
	if !is_active_gate():
		return
	
	if input:
		texture = type_textures[GateTypeEnum.ONE]
	else:
		texture = type_textures[GateTypeEnum.ZERO]

func output() -> bool:
	match type:
		GateTypeEnum.ZERO: return false
		GateTypeEnum.ONE: return true
		GateTypeEnum.AND: 
			# grab both inputs before doing the check
			# in order to update both paths
			var a = input1.output()
			var b = input2.output()
			return a and b
		GateTypeEnum.OR: 
			var a = input1.output()
			var b = input2.output()
			return a or b
		GateTypeEnum.NOT: return !input1.output()
		GateTypeEnum.OUT:
			var out = input1.output()
			if !out:
				out_audio_played = false
			if !out_audio_played and out:
				out_audio_played = true
				$OutAudio.play()
			update_texture(out)
			return out
		GateTypeEnum.IN:
			update_texture(input_value)
			return input_value
	return false

