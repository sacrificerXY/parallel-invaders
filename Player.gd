extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var h := 0
	if Input.is_action_pressed('move_left'):
		h -= 1
	if Input.is_action_pressed('move_right'):
		h += 1
	position.x += h * 800 * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
