extends Node2D

signal room_ready
signal room_change_requested

const GAME_OVER_SCENE = "res://menus/GameOver.tscn"
const WIN_SCENE = "res://menus/WinMenu.tscn"

onready var player = $Player


func _ready():
	emit_signal('room_ready')
	
	player.connect('all_friends_found', self, '_on_Player_all_friends_found')
	player.connect('player_died', self, '_on_Player_player_died')


func _on_Orb_orb_collected():
	player.orbs += 1


func _on_Enemy_light_absorbed():
	player.orbs -= 1
	

func _on_Player_all_friends_found():
	emit_signal('room_change_requested', WIN_SCENE)
	
	
func _on_Player_player_died():
	emit_signal('room_change_requested', GAME_OVER_SCENE)
