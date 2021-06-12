extends Area2D
class_name Bullet

var fired_by: WeakRef
var velocity: Vector2
var focused := false
var gg

func init(fired_by: Node, velocity: Vector2):
	self.fired_by = weakref(fired_by)
	self.velocity = velocity
	
	# TODO adjust collisions

func _physics_process(delta):
	gg = is_in_group('righty')
	if not focused: return
	position += self.velocity * delta


func _on_Bullet_body_entered(body: Node):
	if not focused: return
	if body.is_in_group('damageable'):
		body.deal_damage(5)
		queue_free()
	pass # Replace with function body.

func _ready():
	if is_in_group('righty'):
		print('absdiaduibs')
	if is_in_group('lefty'):
		print('absdiaduibs')

func focus():
	focused = true
	$Sprite.self_modulate.a = 1
	
func unfocus():
	focused = false
	$Sprite.self_modulate.a = 0.2
