extends RigidBody2D
class_name Ball

var _teleport_to: Vector2 = Vector2.ZERO
var _should_teleport: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print(linear_velocity)
	pass
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if _should_teleport:
		state.transform.origin = _teleport_to
		state.linear_velocity = Vector2.ZERO
		_should_teleport = false
	

func teleport_to(_position: Vector2) -> void:
	_should_teleport = true
	_teleport_to = _position
	
