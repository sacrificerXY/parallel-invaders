extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fire_cooldown: float = 0.5
var fire_timer: float = 0

var world

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var h := 0
	if Input.is_action_pressed('move_left'):
		h -= 1
	if Input.is_action_pressed('move_right'):
		h += 1
	position.x += h * 800 * delta

	if fire_timer <= 0:
		if Input.is_action_pressed('fire'): 
			fire_timer = fire_cooldown
			fire()
	else:
		fire_timer -= delta
	
	
func fire():
	var bullet: Bullet = preload('res://Bullet.tscn').instance()
	bullet.init(self, Vector2.UP * 600)
	bullet.position = position
	world.add_bullet(bullet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
