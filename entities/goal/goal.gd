extends Node2D

@export var player: StringName

signal conceded(conceder: StringName)
signal goaltended(goaltender: StringName)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GoaltendingZone/GoaltendingTimer.wait_time = GameState.GOALTEND_TIME
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _draw() -> void:
	var box_size: Vector2= Vector2($TopBar/BarHitbox.shape.size.x, ($GoalArea/HitBox.shape.size.y + $TopBar/BarHitbox.shape.size.y))
	var interval_y = box_size.y / 12 
	var interval_x = box_size.x / 9  
	
	var base = Vector2(-box_size.x / 2, -box_size.y / 2)
	for i in range(12):
		var next_y = base.y + (i * interval_y)
		if i == 0:
			draw_line(Vector2(base.x - .5, next_y), Vector2(box_size.x / 2, next_y), Color.WHITE, 2.0)
		else:
			draw_line(Vector2(base.x, next_y), Vector2(box_size.x / 2, next_y), Color.WHITE, 2.0)
		
	for i in range(10):
		if i == 9:
			var next_x = base.x + (i * (interval_x - .2))
			draw_line(Vector2(next_x, base.y), Vector2(next_x, box_size.y / 2), Color.WHITE, 5.0)
		else:
			var next_x = base.x + (i * (interval_x - .3))
			draw_line(Vector2(next_x, base.y), Vector2(next_x, box_size.y / 2), Color.WHITE, 2.0)

func reset_goaltend_timer() -> void:
	$GoaltendingZone/GoaltendingTimer.wait_time = 3.0
	

func _on_goal_area_body_entered(_body: Node2D) -> void:
	conceded.emit(player)
	
func _on_goaltending_timer_timeout() -> void:
	goaltended.emit(player)

func _on_goaltending_zone_body_entered(body: Node2D) -> void:
	if body.name != "Player" + player:
		return
	if $GoaltendingZone/GoaltendingTimer.is_stopped():
		$GoaltendingZone/GoaltendingTimer.start()

func _on_goaltending_zone_body_exited(body: Node2D) -> void:
	if body.name != "Player" + player:
		return
	$GoaltendingZone/GoaltendingTimer.stop()
	reset_goaltend_timer()


func _on_game_state_smile_update() -> void:
	pass # Replace with function body.
