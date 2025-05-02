extends Area2D

@export var thrust = 100 # Acceleration power
@export var torque = 8 # Turning power
@export var gravity_strength := 3000 # Gravity Multiplier
@export var fuel := 100.0
@export var burn_rate = 12 # Fuel burn rate
var screen_size # Size of the game window.
var velocity = Vector2.ZERO
var gravity_wells = []
var burning = false

signal crashed
signal won
signal burn_started
signal burn_stopped
signal found_planet

# Save initial positions for reset
var initial_velocity
var initial_position
var initial_rotation
var initial_fuel

# Statistics
var distance_traveled := 0.0
var speed := 0.0
var top_speed := 0.0
var visited_planets := []

# For deactivating after death, before start, and after reset
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position
	initial_velocity = velocity
	initial_rotation = rotation
	initial_fuel = fuel
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active:
		return
	
	# Process turning controls
	if Input.is_action_pressed("turn_right"):
		rotation += torque * delta
	if Input.is_action_pressed("turn_left"):
		rotation -= torque * delta
	
	# Process thrust control
	if Input.is_action_pressed("thrust") and fuel > 0:
		velocity += Vector2(0,-1).rotated(rotation) * delta * thrust
		fuel -= delta * burn_rate
		fuel = max(0, fuel)
		$AnimatedSprite2D.animation = "burn"
		if not burning:
			burning = true
			burn_started.emit()
	else:
		$AnimatedSprite2D.animation = "idle"
		if burning:
			burning = false
			burn_stopped.emit()
		
	# Process gravity
	for source in gravity_wells:
		var dist2 = position.distance_squared_to(source.global_position)
		var dir = position.direction_to(source.global_position)
		var accel = dir * source.mass * gravity_strength / max(0.01,dist2)
		velocity += accel
	
	# Update position
	position += velocity * delta
	
	# Update statistics
	distance_traveled += (velocity * delta).length()
	speed = velocity.length()
	top_speed = max(speed, top_speed)

func start(pos):
	position = pos
	show()
	$CollisionPolygon2D.disabled = false

func activate():
	active = true
	show()
	
func deactivate():
	active = false
	if burning:
		burning = false
		burn_stopped.emit()
	hide()

func _on_area_entered(area):
	if area.is_in_group("gravity"):
		if not gravity_wells.has(area):
			gravity_wells.append(area)
	
	if area.is_in_group("obstacle"):
		crashed.emit()
		
	if area.is_in_group("goal"):
		won.emit()

func _on_area_exited(area):
	if area.is_in_group("gravity"):
		gravity_wells.erase(area)

func reset():
	deactivate()
	rotation = initial_rotation
	position = initial_position
	velocity = initial_velocity
	fuel = initial_fuel
	top_speed = 0
	distance_traveled = 0
	visited_planets = []


func _on_visit_area_area_entered(area):
	if area.is_in_group("obstacle") and not visited_planets.has(area):
		visited_planets.append(area)
		found_planet.emit()
