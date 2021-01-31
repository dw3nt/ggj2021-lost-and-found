extends EnemyStateMachine

const MOVE_SPEED = 100
const CLOSE_ENOUGH_DISTANCE = 100

var fsm
var target = null

onready var stopChaseCollision = $StopChaseDetect/CollisionShape2D


func ready():
	pass
	
	
func enter_state(params):
	if params.has("target"):
		target = params['target']
		
	fsm.velocity = Vector2.ZERO
	stopChaseCollision.set_deferred("disabled", false)
	
	
func physics_process(delta):
	if target.position.distance_to(global_position) > CLOSE_ENOUGH_DISTANCE:
		var moveDir = target.position.angle_to_point(global_position)
		moveDir = stepify(rad2deg(moveDir), 45)
		
		fsm.velocity = Vector2.RIGHT.rotated(deg2rad(moveDir)) * MOVE_SPEED
	else:
		fsm.velocity = Vector2.ZERO
	
	
func exit_state():
	stopChaseCollision.set_deferred("disabled", true)


func _on_StopChaseDetect_body_exited(body):
	fsm.change_state("Wander", [])
