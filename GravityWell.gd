@tool
extends Area2D

var shape = CircleShape2D.new()

@export var mass_radius = 40 # multiplied by mass to determine radius

@export_range(1, 100) var mass = 24.0:
	set(value):
		mass = value
		shape.radius = mass_radius * mass


# Called when the node enters the scene tree for the first time.
func _ready():
	shape.radius = mass_radius * mass
	$CollisionShape2D.shape = shape


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

