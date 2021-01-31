extends EnemyStateMachine

const MOVE_SPEED = 50
const MIN_MOVE_TIME = 1.5
const MAX_MOVE_TIME = 3.0

var fsm
var moveRotate = null

onready var rayCastWrap = $RayCasts
onready var moveTimer = $MoveTimer
onready var chaseCollision = $ChaseDetect/CollisionShape2D


func ready():
	pass
	
	
func enter_state(params):
	chaseCollision.set_deferred("disabled", false)
	setMoveDir()
	moveTimer.start(rand_range(MIN_MOVE_TIME, MAX_MOVE_TIME))
	
	
func physics_process(delta):
	for index in rayCastWrap.get_child_count():
		var ray = rayCastWrap.get_child(index)
		if ray.is_colliding():
			setMoveDir()	
	
	
func exit_state():
	chaseCollision.set_deferred("disabled", true)
	moveTimer.stop()
	
	
func setMoveDir():
	var moveDir = Vector2.ZERO
	var notColliding = []
	for ray in rayCastWrap.get_children():
		if !ray.is_colliding():
			notColliding.push_front(ray)
			
	if notColliding.size() > 0:
		notColliding.shuffle()
		
		# average together a random amount of not colliding rays
		var rayCastCount = randi() % notColliding.size()
		for index in range(rayCastCount):
			moveDir += notColliding[index].cast_to
		
		if moveDir == Vector2.ZERO:
			moveDir += notColliding[0].cast_to
			
		if moveDir.x != 0:
			fsm.sprite.scale.x = sign(moveDir.x)
			
		fsm.velocity = moveDir.normalized() * MOVE_SPEED


func _on_MoveTimer_timeout():
	if randi() % 2:
		fsm.velocity = Vector2.ZERO
	else:
		setMoveDir()
		
	moveTimer.start(rand_range(MIN_MOVE_TIME, MAX_MOVE_TIME))


func _on_ChaseDetect_body_entered(body):
	fsm.change_state("Chase", { "target": body })
