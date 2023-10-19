extends Node2D


signal sticks_completed


var _current_count = 0
var _max_count = 3


func add_stick():
	_current_count += 1
	
	var spr = get_node("Stick" + str(_current_count))
	var tween = get_tree().create_tween()
	tween.tween_property(spr, "modulate", Color(1,1,1,1), 1)
	tween.tween_callback(_on_tween_completed)


func remove_stick():
	_current_count = max(0, _current_count-1)


func _on_tween_completed():
	if _current_count >= _max_count:
		emit_signal("sticks_completed")
