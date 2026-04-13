extends Node

class PlayerState:                                                                                                                                                                                                                                
	var score: int = 0                                                                                                                                                                                                                            
	var nation: String = ""                                                                                                                                                                                                                       
	var primary_color: Color                                                                                                                                                                                                               
	var secondary_color: Color                                                                                                                                                                                                           
	var smiling: bool = false                                                                                                                                                                                                                     

var player_state: Dictionary[String, PlayerState] = {                                                                                                                                                                                         
  "1": PlayerState.new(),
  "2": PlayerState.new()
}

var round_count: int = 0
var game_started: bool = false

const PLAYER_1_ORIGIN: Vector2 = Vector2(248.0, 472.0)
const PLAYER_2_ORIGIN : Vector2= Vector2(776.0, 472.0)
const GOALTEND_TIME: float = 3.0

var movement_enabled: bool = true

func update_player_nation(player: StringName, nation: String):
	player_state[player].nation = nation
	var colors = Nations.NationColors[nation]
	player_state[player].primary_color = colors.primary
	player_state[player].secondary_color= colors.secondary

func _ready() -> void:
	player_state["1"].nation = "England"
	player_state["1"].primary_color = Nations.NationColors["England"].primary
	player_state["1"].secondary_color = Nations.NationColors["England"].secondary
	player_state["2"].nation = "Spain"
	player_state["2"].primary_color = Nations.NationColors["Spain"].primary
	player_state["2"].secondary_color = Nations.NationColors["Spain"].secondary
	reset()
	
func reset() -> void:
	player_state["1"].score = 0
	player_state["1"].smiling = false
	player_state["2"].score = 0
	player_state["2"].smiling = false
