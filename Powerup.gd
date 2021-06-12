extends Area2D
class_name Powerup

const SPEED := 400

var spawn_side := 'null'

func _physics_process(delta):
	position.y += SPEED * delta


func _on_Powerup_area_entered(area):
	if area.name == 'Player':
		var gg: Gunner = preload('res://Gunner.tscn').instance()
		gg.add_to_group(spawn_side)
		gg.position.x = area.position.x
		g.world.add_gunner(gg)
		queue_free()
	pass # Replace with function body.
