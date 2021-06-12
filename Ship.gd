extends KinematicBody2D
class_name Ship

signal destroyed(ship)

var direction: Vector2 = Vector2.RIGHT
var is_moving := true

var max_hp := 0
var hp := 0

var row_group := 'fish'

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
		var collision: KinematicCollision2D = move_and_collide(direction * 160 * delta)
		if collision:
			if collision.collider.is_in_group('bouncer'):
				reflect_direction()
#				var adjust = direction * 50 * delta - collision.travel
#				position += adjust
#				get_tree().call_group(row_group, 'reflect_direction')
#				get_tree().call_group(row_group, 'adjust_position_x', -adjust.x)

func reflect_direction():
	direction.x *= -1
	position.y += 10

func adjust_position_x(pos: float):
	position.x += pos

func focus():
	is_moving = true

func unfocus():
	is_moving = false
