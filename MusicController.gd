extends Node

var playlist : Dictionary

var currently_playing : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	playlist = {
		"start_menu": $StartMusic,
		"action": $ActionMusic
	}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func stop_music():
	if currently_playing != null:
		currently_playing.stop()

func play_music(track_title):
	stop_music()
	currently_playing = playlist[track_title]
	currently_playing.play()

