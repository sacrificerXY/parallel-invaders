extends KinematicBody2D
class_name Gunner


var speed: float = 100
var direction: Vector2 = Vector2.RIGHT
var is_updating := true

var fire_cooldown: float = 1
var fire_timer: float = 0.1
func _ready():
	if randf() < 0.5:
		direction = Vector2.LEFT
	speed += rand_range(-1, 1) * 20

func update_move(delta):
	var collision: KinematicCollision2D = move_and_collide(direction * speed * delta)
	if collision:
		if collision.collider.is_in_group('bouncer'):
			direction.x *= -1

func update_fire(delta):
	if fire_timer > 0:
		fire_timer -= delta
	else:
		fire_timer += fire_cooldown
		var b: Bullet = preload('res://GunnerBullet.tscn').instance()
		b.init(self, Vector2.UP * 400)
		b.position = position
		g.world.add_bullet(b)
		print(get_groups())
		if is_in_group('lefty'):
			b.add_to_group('lefty')
		elif is_in_group('righty'):
			b.add_to_group('righty')
		else:
			assert(false)
func _physics_process(delta):
	if is_updating:
		update_move(delta)
		update_fire(delta)


func focus():
	is_updating = true
	$Sprite.self_modulate.a = 1
	
func unfocus():
	is_updating = false
	$Sprite.self_modulate.a = 0.2
	
	
