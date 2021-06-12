extends LinkedShip


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_hp(999999)
	direction = Vector2.RIGHT
	speed = 80
	pass # Replace with function body.

func update_move(delta):
	if is_moving:
		var collision: KinematicCollision2D = move_and_collide(direction * speed * delta)
		if collision:
			if collision.collider.is_in_group('bouncer'):
				reflect_direction()
				
func reflect_direction():
	direction.x *= -1
