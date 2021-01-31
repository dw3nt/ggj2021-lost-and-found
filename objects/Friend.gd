extends Area2D

export(String, "addFlashlight", "upFlashlightSpeed", "upFlashlightRange", "upFlashlightSize") var powerUp


func _on_Friend_body_entered(body):
	body.call(powerUp)
	queue_free()
