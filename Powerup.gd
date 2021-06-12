extends Area2D
class_name Powerup

const SPEED := 80


func _physics_process(delta):
	position.y += SPEED * delta
