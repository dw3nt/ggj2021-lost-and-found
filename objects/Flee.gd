extends EnemyStateMachine

const MOVE_SPEED = 125

var fsm
var source = null


func enter_state(params):
	if params.has("source"):
		source = params['source']
		
	fsm.velocity = Vector2.ZERO
	
	
func physics_process(delta):
	var moveDir = global_position.angle_to_point(source.global_position)
	fsm.velocity = Vector2.RIGHT.rotated(moveDir) * MOVE_SPEED
	
	
func exit_state():
	pass
