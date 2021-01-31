extends Area2D

export(String, "addFlashlight", "upFlashlightSpeed", "upFlashlightRange", "upFlashlightSize") var powerUp
export (Color) var lightColor

onready var light = $Light2D

func _ready():
	light.color = lightColor


func _on_Friend_body_entered(body):
	body.call(powerUp)
	queue_free()
