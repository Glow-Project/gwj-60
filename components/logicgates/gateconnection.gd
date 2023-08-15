extends Line2D

class_name GateConnection

@export var source: Gate
@export var destination: Gate

const ON_COLOR = Color.DARK_ORANGE
const OFF_COLOR = Color.LIGHT_SLATE_GRAY

enum PositionEnum { START, END }

var cached_out: bool = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	add_point(Vector2.ZERO)
	add_point(Vector2.ZERO)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if source != null:
		set_point_position(PositionEnum.START, source.position)
		
	if destination != null:
		set_point_position(PositionEnum.END, destination.position)
		
	if cached_out:
		modulate = ON_COLOR
	else:
		modulate = OFF_COLOR

func output() -> bool:
	cached_out = source.output()
	return cached_out
