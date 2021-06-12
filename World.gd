extends Node2D

# past active
const FOCUS_LEFTY: int = 1
const FOCUS_RIGHTY: int = 2
const FOCUS_BOTH: int = 3


onready var screen_size: Vector2 = get_viewport_rect().size
onready var player := find_node('Player')
var past_focus: int = 0

var spawn_cooldown: float = 3
var spawn_timer: float = 0.0


func _ready():
	randomize()
	assert(g.world == null)
	g.world = self
	adjust_bouncer(find_node('LeftBouncer'), 0.0)
	adjust_bouncer(find_node('CenterBouncer'), 0.5)
	adjust_bouncer(find_node('RightBouncer'), 1.0)
	
	
	var lship = preload('res://MotherShip.tscn').instance()
	lship.position.x = 0.25 * screen_size.x
	lship.position.y = 50
	add_child(lship)
	var rship = preload('res://MotherShip.tscn').instance()
	rship.position.x = 0.75 * screen_size.x
	rship.position.y = 50
	add_child(rship)
	
#	lship.link = weakref(rship)
#	rship.link = weakref(lship)
	lship.link_to(rship)
	rship.link_to(lship)
	
	player.world = self
	pass # Replace with function body.


func adjust_bouncer(area, pos: float):
	var rect: RectangleShape2D = area.get_child(0).shape
	area.position.x = screen_size.x * pos
	area.position.y = screen_size.y / 2
	rect.extents.y = screen_size.y / 2
	rect.extents.x = 20
	print(rect.extents)
	if pos == 0.5:
		rect.extents.x = 60
	
	
func _physics_process(delta):
	check_world_focus()
	if spawn_timer > 0:
		spawn_timer -= delta
	else:
		spawn_timer += spawn_cooldown
		if randf() < 0.5:
			if past_focus == FOCUS_LEFTY or past_focus == FOCUS_BOTH:
				spawn_ships(randi() % 5 + 1, 0, 'lefty')
			elif past_focus == FOCUS_RIGHTY or past_focus == FOCUS_BOTH:
				spawn_ships(randi() % 5 + 1, 0.5, 'righty')
			else: assert(false)
		else:
			spawn_linked_ships()
			
			

func spawn_ships(count: int, start_pos: float, focus: String = ''):
	var side = 'LeftWorld' if start_pos < 0.5 else 'RightWorld'
	var interval = 0.4 / count
	var group_width = interval * ( count - 1 )
	start_pos += 0.25 - (group_width / 2)
	start_pos *= screen_size.x
	var row_group = g.get_next_row_group()
	for i in range(count):
		var ship: Ship = preload('res://Ship.tscn').instance()
		ship.position.x = i * interval * screen_size.x + start_pos
		ship.position.y = 120
		if focus != '':
			ship.row_group = row_group
			ship.add_to_group(focus)
			ship.add_to_group(row_group)
		find_node(side).add_child(ship)
		
func spawn_linked_ships():
	var lship = preload('res://LinkedShip.tscn').instance()
	lship.position.x = 0.25 * screen_size.x
	lship.position.y = 120
	add_child(lship)
	var rship = preload('res://LinkedShip.tscn').instance()
	rship.position.x = 0.75 * screen_size.x
	rship.position.y = 120
	add_child(rship)
	lship.link_to(rship)
	rship.link_to(lship)
	var link: DLink = preload('res://DLink.tscn').instance()
	link.link(lship, rship)
	link.position = Vector2.ZERO
	add_child(link)
	

func add_bullet(bullet: Bullet):
	# do lefty rhigty
	add_child(bullet)

func check_world_focus():
	if player.in_center:
		get_tree().call_group('lefty', 'focus')
		get_tree().call_group('righty', 'focus')
		past_focus = FOCUS_BOTH
		return
		
	var curr_focus := past_focus
	if player.position.x < screen_size.x / 2:
		curr_focus = FOCUS_LEFTY
	else:
		curr_focus = FOCUS_RIGHTY
#	if past_focus != curr_focus:
	if curr_focus == FOCUS_LEFTY:
		get_tree().call_group('lefty', 'focus')
		get_tree().call_group('righty', 'unfocus')
	elif curr_focus == FOCUS_RIGHTY:
		get_tree().call_group('lefty', 'unfocus')
		get_tree().call_group('righty', 'focus')
	else:
		assert(false)
	past_focus = curr_focus
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_powerup(pos: Vector2, focus):
	assert(focus == 'lefty' or focus == 'righty')
	var p: Powerup = preload('res://Powerup.tscn').instance()
	add_child(p)
	p.position = pos
	p.spawn_side = focus


func is_left(pos: Vector2):
	return pos.x < (screen_size.x * 0.5)
	
	
func add_gunner(gg):
	gg.position.y = screen_size.y - 32
	add_child(gg)
