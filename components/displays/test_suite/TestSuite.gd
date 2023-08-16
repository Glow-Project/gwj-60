extends Control

signal boot_start()
signal boot_success()
signal boot_fail()

@export var minigames: Array = []

@onready var boot_btn: Button = %BootButton
@onready var output: RichTextLabel = %Output
@onready var default_output_text := output.text
@onready var anim: AnimationPlayer = $AnimationPlayer

func run_tests() -> void:
	boot_btn.hide()
	output.show()
	emit_signal("boot_start")
	var test_names := {}
	var failed = false
	for game in minigames:
		var text = "%s => ..." % game.name
		test_names[game.name] = text
		output.text += "\n\n\n" + text
	for game in minigames:
		await get_tree().create_timer(randi_range(1, 5)).timeout
		var result = game.validate()
		var passed = result == ""
		var text = "%s => %s" % [game.name, "PASSED" if passed else result]
		output.text = output.text.replace(
			test_names[game.name],
			text)
		if not passed:
			emit_signal("boot_fail")
			anim.play("test_failed")
			await anim.animation_finished
			anim.play("RESET")
			output.hide()
			output.text = default_output_text
			failed = true
			break
	if not failed:
		emit_signal("boot_success")
	else:
		boot_btn.show()
