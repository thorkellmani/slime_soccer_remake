extends Node

var game_state: = { 
	"1": {
		"score": 0,
		"nation": "",
		"primary_color": "",
		"secondary_color": "",
	},
	 "2": {
		"score": 0,
		"nation": "",
		"primary_color": "",
		"secondary_color": "",
	}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Background/Scores/Timer.text = parse_time($MatchTime.time_left)
	pass
	
func parse_time(time: float) -> String:
	var minutes = floorf(time / 60)
	var seconds = fmod(time, 60)
	var ms = fmod(seconds * 10, 10)
	
	#var format_string = "%s was reluctant to learn %s, but now he enjoys it."
	#var actual_string = format_string % ["Estragon", "GDScript"]
	
	var formatted_string: String = "%02d:%02d:%02d" % [minutes, seconds, ms]
	return formatted_string



func _on_goal_conceded(player: StringName) -> void:
	var scoring_player = "1" if player == "2" else "2"
	game_state[scoring_player].score += 1
	update_score_label(scoring_player)

func update_score_label(player: StringName) -> void:
	print(game_state[player].score)
	var score = game_state[player].score
	if player == "1":
		$Background/Scores/Player1Score.text = str(score)
	else:
		$Background/Scores/Player2Score.text = str(score)
