extends Node2D

var highlighted := false

func highlight():
	# avoid bursts
	if highlighted:
		return
	$AnimationPlayer.play("LightArrival")
	highlighted = true

func unhighlight():
	# avoid bursts
	if !highlighted:
		return
	$AnimationPlayer.play("LightLeave")
	highlighted = false
