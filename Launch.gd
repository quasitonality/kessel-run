extends Node

var is_title = true
var main = preload("res://test_scene.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_title and Input.is_anything_pressed():
		$Title.queue_free()
		add_child(main)
		is_title = false
