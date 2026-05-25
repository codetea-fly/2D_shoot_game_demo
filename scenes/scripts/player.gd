extends CharacterBody2D


const SPEED = 300.0
var direction := Vector2.ZERO
var shoot_direction := Vector2.ZERO
var radius = 70

func _process(delta: float) -> void:
	$Line2D.points = [$Sprite2D.position, get_local_mouse_position()]
	shoot_direction = get_local_mouse_position() - $Sprite2D.position
	$weapon.position = $Sprite2D.position + shoot_direction.normalized() * radius
	$weapon.rotation = shoot_direction.angle()

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = direction * SPEED * delta * 100
	

	move_and_slide()
