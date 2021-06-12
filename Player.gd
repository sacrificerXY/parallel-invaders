extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fire_cooldown: float = 0.1
var fire_timer: float = 0

var world
var in_center: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var h := 0
	if Input.is_action_pressed('move_left'):
		h -= 1
	if Input.is_action_pressed('move_right'):
		h += 1
	position.x += h * 320 * delta

	if fire_timer <= 0:
		if Input.is_action_pressed('fire'): 
			fire_timer = fire_cooldown
			fire()
	else:
		fire_timer -= delta
	
	
func fire():
	var bullet: Bullet = preload('res://Bullet.tscn').instance()
	bullet.init(self, Vector2.UP * 400)
	bullet.position = position
	world.add_bullet(bullet)
	bullet.focus()



func _on_Player_body_entered(body: Node):
	if body.name == 'CenterBouncer':
		in_center = true
	pass # Replace with function body.


func _on_Player_body_exited(body):
	if body.name == 'CenterBouncer':
		in_center = false
	pass # Replace with function body.
