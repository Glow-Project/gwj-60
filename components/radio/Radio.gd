extends AudioStreamPlayer2D

signal song_selected(song: Dictionary)

var songs: Array[Dictionary] = [
	{
		"artist": "Beathovn",
		"name": "Mellow on da roof",
		"stream": preload("res://assets/audio/MellowOnDaRoof.mp3"),
	},
	{
		"artist": "Noisetaeter",
		"name": "Mandarin Marshmellow",
		"stream": preload("res://assets/audio/mandarin_marshmallow.mp3"),
	}
]

func play_song() -> void:
	var selected = songs[randi_range(0, len(songs))]
	stream = selected["stream"]
	emit_signal("song_selected", selected)
	play()
