extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -1400.0
const KICK_IMPACT: float = 10000.0
const GRAVITY_SCALE: Vector2 = Vector2(1, 5)

var slime_half_height: float = 0
var ball_on_top: bool = false

func _ready() -> void:
	print($HitBox)
	var min_y: float = INF                                               
	var max_y: float = -INF
	for p in $HitBox.polygon:                                            
		min_y = min(min_y, p.y)
		max_y = max(max_y, p.y) 
		
	slime_half_height = abs((min_y - max_y) / 2)   
	
func handle_inputs() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_collisions() -> void:
	var _collisions = move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.name == "Ball" && !ball_on_top:
			kick_ball(collider, collision.get_normal())
			break


func kick_ball(ball: RigidBody2D, normal: Vector2 ) -> void:
	#if normal.x == 0.0:
		#teleport_ball_on_top(ball)
		
	print("KICK BALl")
	var impulse: Vector2 = Vector2(-normal * KICK_IMPACT)
	ball.apply_impulse(impulse)
	

#func teleport_ball_on_top(ball: RigidBody2D):
	#var anchor = global_position
	#var ball_radius = ball.get_node("HitBox").shape.radius
	#var new_ball_pos = global_position.y - (radius + ball_radius)
	#ball.position

func apply_gravity(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * GRAVITY_SCALE) * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_inputs()
	handle_collisions()


func _draw() -> void:
	draw_colored_polygon($HitBox.polygon, "red")


func _on_below_detector_body_entered(body: Ball) -> void:
	ball_on_top = true
	var slime_position_y: float = global_position.y
	var ball_hit_box: CollisionShape2D = body.get_node("HitBox")
	var ball_radius: float = ball_hit_box.shape.radius * 2 * ball_hit_box.scale.x
	var ball_position: Vector2 = body.global_position
	var new_position : Vector2 = Vector2(ball_position.x, slime_position_y - slime_half_height - ball_radius)
	body.teleport_to(new_position)
