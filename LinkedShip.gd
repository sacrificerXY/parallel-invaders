extends Ship
class_name LinkedShip



var link: WeakRef
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	sway_amount = 200
	sway_time_factor = 0.4


func link_to(ship: Ship):
	assert(ship)
	link = weakref(ship)
	ship.connect('destroyed', self, 'on_partner_destroyed')


func on_partner_destroyed(ship: Ship):
#	queue_free()
	#enrage
	sway_time_factor = 0.8
	pass


func queue_free():
	.queue_free()
	var focus = 'lefty' if g.world.is_left(position) else 'righty'
	print('power ' + focus)
	g.world.spawn_powerup(position, focus)
