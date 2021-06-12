extends Area2D
class_name Powerup

const SPEED := 100

var spawn_side := 'null'

func _physics_process(delta):
	position.y += SPEED * delta


func _on_Powerup_area_entered(area):
	if area.name == 'Player':
		var gg: Gunner = preload('res://Gunner.tscn').instance()
		assert(spawn_side == 'lefty' or spawn_side == 'righty')
		g.world.add_gunner(gg)
		gg.add_to_group(spawn_side)
		gg.position.x = area.position.x
		queue_free()
	pass # Replace with function body.
