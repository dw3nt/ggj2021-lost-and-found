extends Node2D

const BASE_ROTATE_SPEED = 3
const ENEMY_DETECT_BUFFER = 20

var insideWalls = 0 setget setInsideWalls
var rotateSpeed = BASE_ROTATE_SPEED
var scaredEnemies = {}

onready var light = $Light2D
onready var sprite = $Sprite


func _ready():
	for area in light.get_children():
		scaredEnemies[area.name] = []
		area.connect("body_entered", self, "_on_EnemyDetect_body_entered", [area])
		area.connect("body_exited", self, "_on_EnemyDetect_body_exited", [area])
	

func setInsideWalls(val):
	insideWalls = val
	if insideWalls < 0:
		insideWalls = 0
		
	if insideWalls <= 0:
		visible = true
	else:
		visible = false	
		
		
func increaseRotateSpeed():
	rotateSpeed += BASE_ROTATE_SPEED
	
	
func increaseRange():
	light.scale.x = 2
	
	
func increaseWidth():
	light.scale.y = 2

	
func addScaredEnemy(area, enemy):
	var index = scaredEnemies[area.name].find(enemy)
	if index == -1:
		scaredEnemies[area.name].push_front(enemy)
		if enemy.stateWrap.state.name != "Flee":
			enemy.stateWrap.change_state("Flee", { "source": self })
	
	
func removeScaredEnemy(area, enemy):
	var index = scaredEnemies[area.name].find(enemy)
	if index > -1:
		scaredEnemies[area.name].remove(index)
		
	if enemy.stateWrap.state.name != "Wander":
		var shouldWander = true
		for areaId in scaredEnemies.keys():
			for enemy in scaredEnemies[areaId]:
				var i = scaredEnemies[areaId].find(enemy)
				if i > -1:
					shouldWander = false
					
		if shouldWander:
			enemy.stateWrap.change_state("Wander", [])


func _physics_process(delta):	
	if Input.is_action_just_pressed("toggle_light"):
		light.enabled = !light.enabled
	
	var rotateAmount = deg2rad(rotateSpeed)
	var angleToMouse = get_angle_to(get_global_mouse_position())
	if abs(angleToMouse) < rotateAmount:
		rotateAmount = abs(angleToMouse)
		
	if sign(angleToMouse) > 0:
		rotation += rotateAmount
	else:
		rotation -= rotateAmount
		
	# sprite.rotation = -rotation	# keep sprite from rotating


func _on_Flashlight_body_entered(body):
	self.insideWalls += 1


func _on_Flashlight_body_exited(body):
	self.insideWalls -= 1


func _on_EnemyDetect_body_entered(body, area):
	if "Enemy" in body.name:
		var overlaps = area.get_overlapping_bodies()
		if overlaps.size() == 1:
			addScaredEnemy(area, body)
		else:
			for overlap in overlaps:
				if "Wall" in overlap.name:
					var distanceToOverlap = global_position.distance_to(overlap.global_position)
					var distanceToBody = global_position.distance_to(body.global_position)
					if distanceToOverlap > distanceToBody:
						addScaredEnemy(area, body)


func _on_EnemyDetect_body_exited(body, area):
	if "Wall" in body.name:
		var overlaps = area.get_overlapping_bodies()
		for overlap in overlaps:
			if "Enemy" in overlap.name:
				for sublap in overlaps:
					if "Wall" in sublap.name:
						if global_position.distance_to(sublap.global_position) > global_position.distance_to(overlap.global_position):
							addScaredEnemy(area, overlap)
						
	elif "Enemy" in body.name:
		removeScaredEnemy(area, body)
