extends GridContainer

func update_score_label(player: StringName) -> void:
	var score = GameState.player_state[player].score
	
	var score_label: String = "Player %s: %s" % [player, score]
	if player == "1":
		$Player1Score.text = score_label
	else:
		$Player2Score.text = score_label
