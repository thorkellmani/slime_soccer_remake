extends Node

var player_state = { 
	"1": {
		"score": 0,
		"nation": "",
		"primary_color": "",
		"secondary_color": "",
		"smiling": false
	},
	 "2": {
		"score": 0,
		"nation": "",
		"primary_color": "",
		"secondary_color": "",
		"smiling": false	
	}
}

var round_count: int = 0

const PLAYER_1_ORIGIN: Vector2 = Vector2(248.0, 472.0)
const PLAYER_2_ORIGIN : Vector2= Vector2(776.0, 472.0)
const GOALTEND_TIME: float = 3.0

var movement_enabled: bool = true
