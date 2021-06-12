extends Area2D
class_name Bullet

var fired_by: WeakRef
var velocity: Vector2

func init(fired_by: Node, velocity: Vector2):
	self.fired_by = weakref(fired_by)
	self.velocity = velocity
	# adjust collisions
# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	position += self.velocity * delta


func _on_Bullet_body_entered(body: Node):
	if body.is_in_group('damageable'):
		body.deal_damage(100)
		queue_free()
	pass # Replace with function body.
