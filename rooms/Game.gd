extends Node2D

signal room_ready
signal room_change_requested

onready var player = $Player


func _ready():
	emit_signal('room_ready')


func _on_Orb_orb_collected():
	player.orbs += 1


func _on_Enemy_light_absorbed():
	player.orbs -= 1
