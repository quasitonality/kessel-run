@tool
extends Node2D

var initial_scale = 24.0

@export_range(1, 100) var mass = 24.0:
	set(value):
		$GravityWell.mass = value
		mass = value
		
@export_range(1, 100) var radius = 24.0:
	set(value):
		var new_scale = value / 24
		$Surface.scale = Vector2(new_scale, new_scale)
		radius = value

# Called when the node enters the scene tree for the first time.
func _ready():
	$GravityWell.mass = mass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
