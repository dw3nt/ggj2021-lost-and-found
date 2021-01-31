extends KinematicBody2D

signal light_absorbed

onready var stateWrap = $EnemyStateMachine
onready var timer = $AbsorbTimer


func _ready():
	randomize()
	stateWrap.ready()
	
	
func _physics_process(delta):
	stateWrap.state.physics_process(delta)
	move_and_slide(stateWrap.velocity)


func _on_LighAbsorb_body_entered(body):
	timer.start()


func _on_LighAbsorb_body_exited(body):
	timer.stop()


func _on_AbsorbTimer_timeout():
	emit_signal('light_absorbed')
