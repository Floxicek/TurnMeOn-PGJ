extends Area2D

var watergirl_in = false
var fireboy_in = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Fireboy"):
		print("Fireboy finished")
		fireboy_in = true
	elif body.is_in_group("Watergirl"):
		print("Watergirl finished")
		watergirl_in = true
	
	if watergirl_in and fireboy_in:
		SceneManager.next_level()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Fireboy"):
		fireboy_in = false
	elif body.is_in_group("Watergirl"):
		watergirl_in = false
