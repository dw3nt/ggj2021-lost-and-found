extends Node

const ROOM_SIGNALS = {
	"room_ready": "_on_CurrentRoom_room_ready",
	"room_change_requested": "_on_CurrentRoom_room_change_requested"
}

onready var animation = $AnimationPlayer
onready var roomWrap = $Room
onready var audio = $AudioStreamPlayer

var currentRoom


func _ready():
	currentRoom = roomWrap.get_child(0)
	attachSignals(currentRoom)
	audio.play()
	
	
func attachSignals(room):
	for signalName in ROOM_SIGNALS.keys():
		room.connect(signalName, self, ROOM_SIGNALS[signalName])


func _on_CurrentRoom_room_ready():
	animation.play("black_fade_out")
	
	
func _on_CurrentRoom_room_change_requested(scene):
	animation.play("black_fade_in")
	yield(animation, "animation_finished")
	
	roomWrap.remove_child(currentRoom)
	currentRoom.queue_free()
	currentRoom = null
	
	var inst = load(scene).instance()
	attachSignals(inst)
	roomWrap.add_child(inst)
	
	currentRoom = roomWrap.get_child(0)
