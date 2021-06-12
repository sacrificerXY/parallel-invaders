extends Node

var last_row_group: int = 0


func get_next_row_group():
	var nxt := 'ship_row_' + String(last_row_group)
	last_row_group += 1
	return nxt
