@tool
extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.shape.size = size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Area2D/CollisionShape2D.shape.size = size
	$Area2D.position = size / 2
