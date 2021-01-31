extends Control

signal room_ready
signal room_change_requested

const MENU_SCENE = "res://menus/MainMenu.tscn"


func _ready():
	emit_signal('room_ready')


func _on_MenuButton_pressed():
	emit_signal('room_change_requested', MENU_SCENE)
