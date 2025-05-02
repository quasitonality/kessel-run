extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.clear_message()
	$HUD.display_title("Ready")
	$MusicController.play_music("start_menu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD.update_fuel($Player.fuel)

func _on_hud_exit():
	get_tree().quit()

func _on_hud_start():
	$MusicController.play_music("action")
	$Player.activate()

func _on_hud_reset():
	$HUD.hide_scores()
	$HUD.display_title("Ready")
	$MusicController.play_music("start_menu")
	$Player.reset()
	$GoalArea.show()

func _on_player_crashed():
	$Player.deactivate()
	$HUD.display_title("Game Over")
	$HUD.display_message("You crashed!")
	$SoundController.play_sound("crash")
	$MusicController.stop_music()

func _on_player_won():
	var scores = {
		"Fuel Remaining": ceil($Player.fuel),
		"Top Speed": floor($Player.top_speed),
		"Distance Traveled": floor($Player.distance_traveled),
		"Planets Visited": str($Player.visited_planets.size()) + "/7"
	}
	$Player.deactivate()
	$GoalArea.hide()
	$HUD.display_title("You Win!")
	$HUD.display_message("Woot")
	$HUD.display_scores(scores)
	$SoundController.play_sound("win")

func _on_hud_button_pressed():
	$SoundController.play_sound("button")

func _on_player_burn_started():
	$SoundController.play_sound("burn")

func _on_player_burn_stopped():
	$SoundController.stop_sound("burn")
