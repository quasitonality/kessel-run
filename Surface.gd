extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func color_shift():
	AnimatedSprite2D.modulate = Color8(92,0,255)
	
func color_reset():
	AnimatedSprite2D.modulate = Color("WHITE")
