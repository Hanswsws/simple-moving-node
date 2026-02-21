extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

const DODGE_SPEED = 600.0
const DODGE_DURATION = 0.2
const DODGE_COOLDOWN = 0.1

var is_dodging = false
var dodge_time = 0.0
var dodge_cooldown_timer = 0.0
var dodge_direction = 1   # default facing right


func _physics_process(delta: float) -> void:
	
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction := Input.get_axis("ui_left", "ui_right")

	# Save last movement direction
	if direction != 0:
		dodge_direction = direction


	# Dodge input
	if Input.is_action_just_pressed("dodge") and dodge_cooldown_timer <= 0:
		is_dodging = true
		dodge_time = DODGE_DURATION
		dodge_cooldown_timer = DODGE_COOLDOWN


	# Dodge movement
	if is_dodging:
		velocity.x = dodge_direction * DODGE_SPEED
		dodge_time -= delta
		
		if dodge_time <= 0:
			is_dodging = false
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)


	# Cooldown
	if dodge_cooldown_timer > 0:
		dodge_cooldown_timer -= delta


	move_and_slide()
