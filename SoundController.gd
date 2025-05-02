extends Node

var playlist : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	playlist = {
		"button": $Blip,
		"crash": $Explosion,
		"burn": $Rocket,
		"win": $Win
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_sound(track):
	playlist[track].play()
	
func stop_sound(track):
	playlist[track].stop()
