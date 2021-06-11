extends KinematicBody2D

var direction: Vector2 = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _process(delta: float):
	var collision: KinematicCollision2D = move_and_collide(direction * 400 * delta)
	if collision:
		if collision.collider.is_in_group('bouncer'):
			direction.x *= -1
			position.y += 10
