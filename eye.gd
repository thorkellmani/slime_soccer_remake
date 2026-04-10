extends Sprite2D

var ball_ref: Ball
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball_ref = get_node("../../Ball")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	look_at(ball_ref.global_position)
	
