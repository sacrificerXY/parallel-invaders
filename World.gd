extends Node2D

# past active
const FOCUS_LEFTY: int = 1
const FOCUS_RIGHTY: int = 2

onready var screen_size: Vector2 = get_viewport_rect().size
onready var player := find_node('Player')
var past_focus: int = 0

func _ready():
	adjust_bouncer(find_node('LeftBouncer'), 0.0)
	adjust_bouncer(find_node('CenterBouncer'), 0.5)
	adjust_bouncer(find_node('RightBouncer'), 1.0)
	pass # Replace with function body.


func adjust_bouncer(area, pos: float):
	var rect: RectangleShape2D = area.get_child(0).shape
	area.position.x = screen_size.x * pos
	area.position.y = screen_size.y / 2
	rect.extents.y = screen_size.y / 2
	rect.extents.x = 20
	
	
func _process(delta):
	check_world_focus()


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
