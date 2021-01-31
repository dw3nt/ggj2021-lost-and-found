extends Control

signal room_ready
signal room_change_requested

const GAME_SCENE = "res://rooms/Game.tscn"


func _ready():
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("room_change_requested", GAME_SCENE)