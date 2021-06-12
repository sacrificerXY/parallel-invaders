extends Line2D
class_name DLink


var ship1: WeakRef
var ship2: WeakRef

func _ready():
	position = Vector2.ZERO
	scale = Vector2(1, 1)

func link(ship1: Ship, ship2: Ship):
	self.ship1 = weakref(ship1)
	self.ship2 = weakref(ship2)
	ship1.connect('destroyed', self, 'on_ship_destroyed')
	ship2.connect('destroyed', self, 'on_ship_destroyed')

func on_ship_destroyed(ship: Ship):
	queue_free()

func _process(delta):
	clear_points()
	var p1: Vector2 = ship1.get_ref().position
	var p2: Vector2 = ship2.get_ref().position
	add_point(p1)
	add_point(p2)
	
func _physics_process(delta):
	var p1: Vector2 = ship1.get_ref().position
	var p2: Vector2 = ship2.get_ref().position
	var d := (p1 + p2) / 2
	$Link.position = d
	$Link.position.x = ProjectSettings.get_setting('display/window/size/width') * 0.5
