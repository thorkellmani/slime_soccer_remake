extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -1400.0
const BASE_IMPACT: float = 200.0
const IMPACT_SCALE: float = 35.0

const GRAVITY_SCALE: Vector2 = Vector2(1, 5)

@export var color: Color
@export var action_left: StringName
@export var action_right: StringName
@export var action_up: StringName
@export var orientation: StringName
@export var player: StringName

var slime_half_height: float = 0
var kick_cooldown: float = 0.0

func _ready() -> void:
	var min_y: float = INF                                               
	var max_y: float = -INF
	for p in $HitBox.polygon:                                            
		min_y = min(min_y, p.y)
		max_y = max(max_y, p.y) 
		
	slime_half_height = abs((min_y - max_y) / 2)   
	
	if player == "1":
		get_node("../Background/GoalLineTimer1").color = color
	else:
		get_node("../Background/GoalLineTimer2").color = color
	
	
	if orientation == "left":
		scale.x *= -1
	
func handle_inputs() -> void:
	var direction := Input.get_axis(action_left, action_right)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
		
func kick_ball(ball: Ball, normal: Vector2) -> void:
	var impulse =  -normal * (BASE_IMPACT + IMPACT_SCALE * velocity.length())      
	ball.apply_impulse(impulse)
	
func teleport_ball(ball: Ball):
	var slime_position_y: float = global_position.y
	var ball_hit_box: CollisionShape2D = ball.get_node("HitBox")
	var ball_radius: float = ball_hit_box.shape.radius * 2 * ball_hit_box.scale.x
	var ball_position: Vector2 = ball.global_position
	var new_position : Vector2 = Vector2(ball_position.x, slime_position_y - slime_half_height - ball_radius)
	ball.teleport_to(new_position)

func apply_gravity(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * GRAVITY_SCALE) * delta

	if Input.is_action_just_pressed(action_up) and is_on_floor():
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	if !GameState.movement_enabled:
		return
		
	apply_gravity(delta)
	handle_inputs()
	move_and_slide()
	
	if kick_cooldown > 0.0:
		kick_cooldown = maxf(kick_cooldown - delta, 0.0)               


func _draw() -> void:
	draw_colored_polygon($HitBox.polygon, color)
	if GameState.player_state[player].smiling:
		draw_arc($SmileReference.position, 35.0, deg_to_rad(45), deg_to_rad(150), 15, Color.BLACK, 1.0, true)
	

func _on_ball_detector_body_entered(body: Ball) -> void:
	if kick_cooldown <= 0.0:
		var normal = (global_position - body.global_position).normalized()
		kick_cooldown = .25
		if normal.y < 0:
			teleport_ball(body)
		else:
			kick_ball(body, normal)


func _on_main_smile_update() -> void:
	if GameState.player_state[player].smiling:
		queue_redraw()
