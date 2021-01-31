extends Node2D

class_name EnemyStateMachine

const HISTORY_LIMIT = 10

export(NodePath) var animationPlayerPath
export(NodePath) var spritePath

var state
var velocity = Vector2.ZERO
var history = []

var anim
var sprite


func ready():
	if animationPlayerPath:
		anim = get_node(animationPlayerPath)
	if spritePath:
		sprite = get_node(spritePath)
	
	if anim:
		anim.connect("animation_finished", self, "_on_FSM_Anim_animation_finished")
	
	state = get_child(0)
	state.fsm = self
	state.enter_state([])
	
	
func change_state(newStateName, params):
	print(newStateName)
	update_history(newStateName)
	state.exit_state()
	state = get_node(newStateName)
	state.fsm = self
	state.enter_state(params)
	
	
func update_history(stateName):
	if history.size() > HISTORY_LIMIT:
		history.pop_front()
		
	history.append(state.name)
	
	
func enter_state(params):
	pass
	
	
func process(delta):
	pass
	
	
func physics_process(delta):
	pass
	
	
func input(event):
	pass
	
	
func animation_finished(anim_name):
	pass
	
	
func exit_state():
	pass
	
	
func _on_FSM_Anim_animation_finished(anim_name):
	state.animation_finished(anim_name)
