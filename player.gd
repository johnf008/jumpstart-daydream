extends CharacterBody2D

@onready var win: Label = %win

const SPEED = 800.0
const JUMP_VELOCITY = -900.0
var double_jump = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("jump") and !is_on_floor() and double_jump:
		velocity.y = JUMP_VELOCITY
		double_jump = false
	
	if is_on_floor():
		double_jump = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 40)

	move_and_slide()


func _on_mango_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		win.visible = true
