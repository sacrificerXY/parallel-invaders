extends Node2D


func _ready():
	adjust_bouncer(find_node('LeftBouncer'), 0.0)
	adjust_bouncer(find_node('CenterBouncer'), 0.5)
	adjust_bouncer(find_node('RightBouncer'), 1.0)
	pass # Replace with function body.


func adjust_bouncer(area, pos: float):
	var screen_size: Vector2 = get_viewport_rect().size
	var rect: RectangleShape2D = area.get_child(0).shape
	area.position.x = screen_size.x * pos
	area.position.y = screen_size.y / 2
	rect.extents.y = screen_size.y / 2
	rect.extents.x = 20
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
