extends Control

signal room_ready
signal room_change_requested

const MENU_SCENE = "res://menus/MainMenu.tscn"


func _ready():
	emit_signal('room_ready')


func _on_MenuButton_pressed():
	emit_signal('room_change_requested', MENU_SCENE)


func _on_SongButton_pressed():
	OS.shell_open("https://freemusicarchive.org/music/jim-hall/synth-kid-elsewhere/wanderlust")


func _on_ArtistButton_pressed():
	OS.shell_open("https://freemusicarchive.org/music/jim-hall")


func _on_LicenseButton_pressed():
	OS.shell_open("https://creativecommons.org/licenses/by/4.0/legalcode")
