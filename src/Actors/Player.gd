extends Actor
export var stomp_impulse: = 600.0

func _physics_process(_delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, floor_normal)
	
	set_flip()
	
	for i in get_slide_count():
		var collision: = get_slide_collision(i)
		var collider: = collision.collider
		var is_stomping: = (
			collider is Enemy and
			is_on_floor() and
			collision.normal.is_equal_approx(Vector2.UP)
		)
		
		if is_stomping:
			velocity.y = -stomp_impulse
			(collider as Enemy).kill()

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity

func set_flip():
	if velocity.x == 0:
		return
	$player.flip_h = true if velocity.x < 0 else false

func kill():
	pass

func _on_EnemyDetector_body_entered(_body: Node) -> void:
	print_debug("Enemy body entered")
	queue_free()

func _on_EnemyDetector_area_entered(_area: Area2D) -> void:
	print_debug("Enemy area entered")
