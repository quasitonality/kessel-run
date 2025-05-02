extends CanvasLayer

signal start
signal reset
signal exit
signal button_pressed


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fuel.hide()
	$ScoreBoard.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_fuel(fuel):
	$Fuel.text = "Fuel: " + str(ceil(fuel))
	
# Accepts a dictionary
func display_scores(values):
	for node in $ScoreBoard.get_children():
		node.queue_free()
	for key in values:
		var stat = Label.new()
		var val = Label.new()
		stat.text = key + ":"
		val.text = str(values[key])
		$ScoreBoard.add_child(stat)
		$ScoreBoard.add_child(val)
	$ScoreBoard.show()
	
func hide_scores():
	$ScoreBoard.hide()
	
func display_title(text):
	$Title.text = text
	$Title.show()
	
func clear_title():
	$Title.hide()
	
func display_message(text):
	$Message.text = text
	$Message.show()
	
func clear_message():
	$Message.hide()
	
func _on_start_pressed():
	button_pressed.emit()
	start.emit()
	$Start.hide()
	$Message.hide()
	$Title.hide()
	$Fuel.show()
	
func _on_reset_pressed():
	button_pressed.emit()
	reset.emit()
	$Fuel.hide()
	display_title("Start")
	clear_message()
	$Start.show()
	
func _on_quit_pressed():
	button_pressed.emit()
	exit.emit()
