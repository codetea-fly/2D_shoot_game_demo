extends CharacterBody2D


const SPEED = 300.0
var direction := Vector2.ZERO
var shoot_direction := Vector2.ZERO
var radius = 70
var shoot_speed := Vector2(300.0, 0.0)
var can_fire :bool = false
@export var arrow_scene : PackedScene

func _process(delta: float) -> void:
	shoot_direction = get_local_mouse_position() - $Sprite2D.position
	$weapon.position = $Sprite2D.position + shoot_direction.normalized() * radius
	$weapon.rotation = shoot_direction.angle()
	$Line2D.points = [to_local($weapon/Marker2D.global_position), get_local_mouse_position()]
	if Input.is_action_pressed("fire") and can_fire:
		fire(to_local($weapon/Marker2D.global_position),get_local_mouse_position(), shoot_direction)

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = direction * SPEED * delta * 100
	

	move_and_slide()

func fire(start_pos:Vector2, target_pos:Vector2, shoot_dir:Vector2) -> void:
	var arrow = arrow_scene.instantiate()
	arrow.position = start_pos
	var direction = shoot_direction
	arrow.rotation = direction.angle()
	arrow.linear_velocity = shoot_speed.rotated(direction.angle())
	can_fire = false
	add_child(arrow)
		


func _on_fire_timer_timeout() -> void:
	can_fire = true
