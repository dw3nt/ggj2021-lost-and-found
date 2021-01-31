extends Control

signal room_ready
signal room_change_requested

const GAME_SCENE = "res://rooms/Game.tscn"
const MENU_SCENE = "res://menus/MainMenu.tscn"


func _ready():
	emit_signal('room_ready')


func _on_RetryButton_pressed():
	emit_signal('room_change_requested', GAME_SCENE)


func _on_MenuButton_pressed():
	emit_signal('room_change_requested', MENU_SCENE)
