extends Node2D

# past active
const FOCUS_LEFTY: int = 1
const FOCUS_RIGHTY: int = 2


onready var screen_size: Vector2 = get_viewport_rect().size
onready var player := find_node('Player')
var past_focus: int = 0

var spawn_cooldown: float = 4
var left_spawn_timer: float = 0.0
var right_spawn_timer: float = 0.0

func _ready():
	adjust_bouncer(find_node('LeftBouncer'), 0.0)
	adjust_bouncer(find_node('CenterBouncer'), 0.5)
	adjust_bouncer(find_node('RightBouncer'), 1.0)
	
	player.world = self
	pass # Replace with function body.


func adjust_bouncer(area, pos: float):
	var rect: RectangleShape2D = area.get_child(0).shape
	area.position.x = screen_size.x * pos
	area.position.y = screen_size.y / 2
	rect.extents.y = screen_size.y / 2
	rect.extents.x = 20
	
	
func _physics_process(delta):
	check_world_focus()
	if past_focus == FOCUS_LEFTY:
		if left_spawn_timer > 0:
			left_spawn_timer -= delta
		else:
			left_spawn_timer += spawn_cooldown
			spawn_ships(3, 0, 'lefty')
			
	# change for temporal center
	elif past_focus == FOCUS_RIGHTY:
		if right_spawn_timer > 0:
			right_spawn_timer -= delta
		else:
			right_spawn_timer += spawn_cooldown
			spawn_ships(3, 0.5, 'righty')
			
	else: assert(false)
	print()
			

func spawn_ships(count: int, start_pos: float, focus: String = ''):
	var side = 'LeftWorld' if start_pos < 0.5 else 'RightWorld'
	var interval = 0.5 / count
	var group_width = interval * ( count - 1 )
	start_pos += 0.25 - (group_width / 2)
	start_pos *= screen_size.x
	var row_group = g.get_next_row_group()
	for i in range(count):
		var ship: Ship = preload('res://Ship.tscn').instance()
		ship.position.x = i * interval * screen_size.x + start_pos
		ship.position.y = 100
		if focus != '':
			ship.row_group = row_group
			ship.add_to_group(focus)
			ship.add_to_group(row_group)
		find_node(side).add_child(ship)
		
		

func add_bullet(bullet: Bullet):
	# do lefty rhigty
	add_child(bullet)

func check_world_focus():
	var curr_focus := past_focus
	if player.position.x < screen_size.x / 2:
		curr_focus = FOCUS_LEFTY
	else:
		curr_focus = FOCUS_RIGHTY
	if past_focus != curr_focus:
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
