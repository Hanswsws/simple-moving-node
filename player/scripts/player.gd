extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement + Flip sprite
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0   # 👈 flip here
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
