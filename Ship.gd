extends KinematicBody2D
class_name Ship

signal destroyed(ship)

var direction: Vector2 = Vector2.RIGHT
var is_moving := true

var max_hp := 0
var hp := 0


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_hp(20)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reset_hp(max_hp: float):
	assert(max_hp > 0)
	self.max_hp = max_hp
	self.hp = max_hp

func deal_damage(damage: float) -> void:
	hp -= damage
	hp = clamp(hp, 0, max_hp)
	if hp == 0:
		emit_signal('destroyed', self)
		queue_free()


func _physics_process(delta):
	if is_moving:
		var collision: KinematicCollision2D = move_and_collide(direction * 400 * delta)
		if collision:
			if collision.collider.is_in_group('bouncer'):
				direction.x *= -1
				position.y += 5

func focus():
	is_moving = true
	print('focus')

func unfocus():
	is_moving = false
	print('unfocus')
