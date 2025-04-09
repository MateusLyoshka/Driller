extends CharacterBody2D

const SPEED: int = 200
const JUMP: int = 300

@onready var knight: AnimatedSprite2D = $Knight
@onready var block_break: Timer = $"../BlockBreak"

var mining:bool = true

func _process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction = Input.get_axis("Left","Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	if mining and Input.is_action_pressed("Click"):
		block_break.start()
		mining = false
		knight.play("Mine")
		if direction != 0:
			knight.flip_h = direction < 0
	elif not Input.is_action_pressed("Click") and mining:
		# Only update animation if not mining
		if direction != 0:
			knight.flip_h = direction < 0
			knight.play("Running")
		else:
			knight.play("Idle")
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y -= JUMP
	
	move_and_slide()

func _on_block_break_timeout() -> void:
	mining = true
	pass
