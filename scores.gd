extends GridContainer

func update_score_label(player: StringName) -> void:
	var player_data := GameState.player_state[player]
	
	var score_label: String = "%s: %s" % [player_data.nation, player_data.score]
	if player == "1":
		$Player1Score.text = score_label
	else:
		$Player2Score.text = score_label
