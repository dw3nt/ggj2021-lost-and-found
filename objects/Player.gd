extends KinematicBody2D

signal player_died

const FLASHLIGHT_SCENE = preload("res://objects/Flashlight.tscn")

const MOVE_DIRS = [ "move_right", "move_down", "move_left", "move_up" ]
const MOVE_SPEED = 200

const BASE_ORBS = 5
const ORB_LIGHT_INCREASE = 0.05
const MAX_ORBS = 15
const MIN_ORBS = 0

var orbs setget setOrbs
var inputDir = Vector2.ZERO
var flashlight = null

onready var light = $Light2D


func _ready():
	self.orbs = BASE_ORBS


func setOrbs(val):
	orbs = clamp(val, MIN_ORBS, MAX_ORBS)
	# tween this
	light.texture_scale = (orbs * ORB_LIGHT_INCREASE)
	
	if orbs <= 0:
		emit_signal('player_died')

		
func _physics_process(delta):
	getInput()
	move_and_slide(inputDir.normalized() * MOVE_SPEED)
	
	
func getInput():
	inputDir = Vector2.ZERO
	for index in MOVE_DIRS.size():
		if Input.is_action_pressed(MOVE_DIRS[index]):
			var rotateAmount = deg2rad(90 * index)
			inputDir += Vector2.RIGHT.rotated(rotateAmount).round()
			
			
func addFlashlight():
	flashlight = FLASHLIGHT_SCENE.instance()
	call_deferred("add_child", flashlight)
	

func upFlashlightSpeed():
	if flashlight:
		flashlight.increaseRotateSpeed()
	
	
func upFlashlightRange():
	if flashlight:
		flashlight.increaseRange()
	
	
func upFlashlightSize():
	if flashlight:
		flashlight.increaseWidth()
