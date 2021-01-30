extends Control

signal room_ready
signal room_change_requested

const SCENE_1 = "res://menus/Scene1.tscn"


func _ready():
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("room_change_requested", SCENE_1)
