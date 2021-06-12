extends Ship
class_name LinkedShip



var link: WeakRef
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func link_to(ship: Ship):
	assert(ship)
	link = weakref(ship)
	ship.connect('destroyed', self, 'on_partner_destroyed')


func on_partner_destroyed(ship: Ship):
	queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
