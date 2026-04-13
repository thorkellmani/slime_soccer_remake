extends Node

const INITIAL_BALL_POSITION = Vector2(512.0, 255.0)

signal smile_update

var max_goaltend_line_size: float

func _ready() -> void:
	$Ball.freeze = true
	max_goaltend_line_size = $Background/GoalLineTimer1.size.x
	$Background/GoalLine.size.x = $Goal1/GoaltendingZone/DetectionArea.shape.size.x
	$Background/GoalLine2.size.x = $Goal2/GoaltendingZone/DetectionArea.shape.size.x
	update_player_labels()

func _process(_delta: float) -> void:
	$HUD/Scores/Timer.text = $MatchTime.parse_time()
	update_goaltend()
	
func reset() -> void:
	$MatchTime.paused = true
	Engine.time_scale = 1.0
	$HUD/PlayerScoredLabel.text = ""
	$Player1.position = GameState.PLAYER_1_ORIGIN
	$Player1.velocity = Vector2(0,0)
	$Player2.position = GameState.PLAYER_2_ORIGIN
	$Player2.velocity = Vector2(0,0)
	$Goal1.reset_goaltend_timer()
	$Goal2.reset_goaltend_timer()
	$Ball.teleport_to(INITIAL_BALL_POSITION)
	$Ball.show()
	$Ball.freeze = true
	
func update_goaltend() -> void:
	var update_line = func(timer: Timer, line: ColorRect):
		#is not goaltending and line is not reset, reset it.INITIAL_BALL_POSITION
		if !timer.is_stopped():
			var time_left_ratio: float = timer.time_left / GameState.GOALTEND_TIME
			line.size.x = max_goaltend_line_size * time_left_ratio
		elif line.size.x != max_goaltend_line_size:
			line.size.x = max_goaltend_line_size
			
	update_line.call($Goal1/GoaltendingZone/GoaltendingTimer, $Background/GoalLineTimer1)
	update_line.call($Goal2/GoaltendingZone/GoaltendingTimer,  $Background/GoalLineTimer2)
	
func start_round() -> void:
	$HUD/RoundCounter.text = "ROUND  " + str(GameState.round_count)
	await get_tree().create_timer(.8).timeout
	$Ball.freeze = false
	GameState.movement_enabled = true
	$HUD/RoundCounter.text = ""
	$MatchTime.paused = false
	get_tree().paused = false
	
func new_game(match_time: float) -> void:
	$MatchTime.wait_time = match_time
	$MatchTime.start()
	$Background/GameMenu.hide()
	$HUD/GameOverContainer.hide()
	GameState.reset()
	update_player_labels()
	prepare_new_round()
	GameState.game_started = true
	
func prepare_new_round() -> void:
	GameState.round_count += 1
	GameState.movement_enabled = false
	reset()
	start_round()
	
	
func execute_scoring(player: StringName, scoring_action: String) -> void:
	$Goal1/GoaltendingZone/GoaltendingTimer.stop()
	$Goal2/GoaltendingZone/GoaltendingTimer.stop()
	var player_data = GameState.player_state[player]
	player_data.score += 1
	check_if_smile()
	$HUD/Scores.update_score_label(player)
	$HUD/PlayerScoredLabel.text = str(player_data.nation + " " + scoring_action)
	Engine.time_scale = 0.1
	$OnScoreTimer.start()

func check_if_smile() -> void:
	var player_1 = GameState.player_state["1"]
	var player_2 = GameState.player_state["2"]
	
	if abs(player_1.score - player_2.score) > 2:
		var smiling_player = "1" if player_1.score > player_2.score else "2"
		GameState.player_state[smiling_player].smiling = true
	elif player_1.smiling:
		player_1.smiling = false
	elif player_2.smiling:
		player_2.smiling = false
	
	smile_update.emit()

	
	
func _on_goal_conceded(conceder: StringName) -> void:
	execute_scoring("1" if conceder == "2" else "2", "scored!")
	
func _on_goaltend(goaltender: StringName) -> void:
	execute_scoring(goaltender, "goal hanged!")


func _on_match_end() -> void:
	var player_1 = GameState.player_state["1"]
	var player_2 = GameState.player_state["2"]
	$HUD/GameOverContainer.show()
	$HUD/GameOverContainer/FinalScoreContainer/Player1.text = str(player_1.nation)
	$HUD/GameOverContainer/FinalScoreContainer/Player2.text = str(player_2.nation)
	$HUD/GameOverContainer/FinalScoreContainer/Score.text = str(player_1.score) + " - " + str(player_2.score)
	$Background/GameMenu.show()
	GameState.game_started = false
	reset()
	

func _on_game_length_picked(minutes: int) -> void:
	new_game(minutes)
	
func update_player_labels() -> void:
	$HUD/Scores.update_score_label("1") 
	$HUD/Scores.update_score_label("2")

func _on_player_nation_update() -> void:
	update_player_labels()
	$Background/GoalLineTimer1.color = GameState.player_state["1"].secondary_color
	$Background/GoalLineTimer2.color = GameState.player_state["2"].secondary_color
	
