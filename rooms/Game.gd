extends Node2D

signal room_ready
signal room_change_requested

const GAME_SCENE = "res://rooms/Game.tscn"
const MENU_SCENE = "res://menus/MainMenu.tscn"
const GAME_OVER_SCENE = "res://menus/GameOver.tscn"
const WIN_SCENE = "res://menus/WinMenu.tscn"

onready var player = $Player
onready var orbSfx = $OrbSfx
onready var lightDrainSfx = $LightDrainSfx


func _ready():
	emit_signal('room_ready')
	
	player.connect('all_friends_found', self, '_on_Player_all_friends_found')
	player.connect('player_died', self, '_on_Player_player_died')
	
	
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("restart_level"):
			emit_signal('room_change_requested', GAME_SCENE)
		if event.is_action_pressed("quit_level"):
			emit_signal('room_change_requested', MENU_SCENE)
		


func _on_Orb_orb_collected():
	orbSfx.play()
	player.orbs += 1


func _on_Enemy_light_absorbed():
	lightDrainSfx.play()
	player.orbs -= 1
	

func _on_Player_all_friends_found():
	emit_signal('room_change_requested', WIN_SCENE)
	
	
func _on_Player_player_died():
	emit_signal('room_change_requested', GAME_OVER_SCENE)
