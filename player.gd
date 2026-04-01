extends CharacterBody2D

const MAX_BALL_SPEED = 250.0
const SPEED = 400.0
const JUMP_VELOCITY = -1400.0
const BASE_IMPULSE_FACTOR = -70.0


@export var radius: float = 75.0

var arc_points: Array[Vector2] = []

func _ready() -> void:
	for idx in range(33):
		var point = Vector2.from_angle((PI/32) * idx + PI) * radius
		arc_points.push_back(point)
	
	$HitBox.polygon = PackedVector2Array(arc_points)
	$HeadSpike.position = Vector2(0, -radius)
	arc_points.push_back(Vector2.ZERO)
	
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
		if collider.name == "Ball":
			kick_ball(collider, collision.get_normal())
			break

func kick_ball(ball: RigidBody2D, normal: Vector2 ) -> void:
	var impulse: Vector2 = Vector2(normal.x * BASE_IMPULSE_FACTOR, velocity.y * BASE_IMPULSE_FACTOR * 5 - 100)
	print(impulse.limit_length(250.0))
	ball.apply_impulse(impulse.limit_length(250.0))
	
	#cap max impulse
	ball.linear_velocity.limit_length(MAX_BALL_SPEED)
	

func apply_gravity(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_inputs()
	handle_collisions()


func _draw() -> void:
	draw_colored_polygon(arc_points, "red")
