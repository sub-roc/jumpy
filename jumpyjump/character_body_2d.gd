extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim_sprite = $AnimatedSprite2D  # cache reference

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction (-1 for left, 1 for right, 0 for none)
	var direction := Input.get_axis("left", "right")
	
	if direction != 0:
		velocity.x = direction * SPEED

		# Flip sprite based on direction
		anim_sprite.flip_h = direction < 0

		# Play walk animation if not already playing
		if anim_sprite.animation != "walk":
			anim_sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		# Play idle animation when stopped
		if anim_sprite.animation != "idle":
			anim_sprite.play("idle")

	move_and_slide()
