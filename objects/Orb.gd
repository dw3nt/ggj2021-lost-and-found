extends Area2D

signal orb_collected


func _on_Orb_body_entered(body):
	emit_signal('orb_collected')
	queue_free()
