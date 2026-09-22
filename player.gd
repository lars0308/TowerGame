extends CharacterBody2D

const SPEED := 200.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction := Vector2.DOWN
var attacking := false

func _physics_process(_delta: float) -> void:
	if attacking:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = direction * SPEED

	if direction != Vector2.ZERO:
		last_direction = direction

		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				sprite.play("runright")
			else:
				sprite.play("runleft")
		else:
			if direction.y > 0:
				sprite.play("rundown")
			else:
				sprite.play("runup")
	else:
		sprite.stop()

	if Input.is_action_just_pressed("attack"):
		attack()

	move_and_slide()


func attack() -> void:
	attacking = true
	velocity = Vector2.ZERO

	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x > 0:
			sprite.play("attackright")
		else:
			sprite.play("attackleft")
	else:
		if last_direction.y > 0:
			sprite.play("attackdown")
		else:
			sprite.play("attackup")

	await sprite.animation_finished
	attacking = false
