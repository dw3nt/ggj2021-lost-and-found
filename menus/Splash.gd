extends Control

signal room_ready
signal room_change_requested

const MENU_SCENE = "res://menus/MainMenu.tscn"


func _ready():
	yield(get_tree().create_timer(0.2), "timeout")
	emit_signal("room_change_requested", MENU_SCENE)
