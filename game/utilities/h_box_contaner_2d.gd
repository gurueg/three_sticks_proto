@tool
extends Node2D
class_name HBoxContainer2D

@export var separation:int = 4
@export var cellsize:float = 10
@export var max_width:float = 0
#@export var alignment:BoxContainer.AlignmentMode = BoxContainer.ALIGNMENT_CENTER

func _process(delta):
	_update_container()

func _update_container() -> void:
	var childs_list = get_children()
	if childs_list.size() == 0: 
		return
	
	var obj_diff = separation + cellsize
	if max_width != 0:
		obj_diff = max_width/childs_list.size()
		obj_diff = min(obj_diff, cellsize)
	
	var left_position = (childs_list.size() - 1) * (obj_diff/-2)

	var child_number = 1
	for child in childs_list:
		child.position.x = left_position + (child_number - 1) * obj_diff
		child_number += 1


func _on_child_entered_tree(child:Node) -> void:
	if !child.is_connected("tree_exited", _update_container):
		child.connect("tree_exited", _update_container)
		
	_update_container()

func get_child_index_by_position(pos:float) -> int:
	var childs_list = get_children()
	if childs_list.size() == 0: 
		return 0
	
	var obj_diff = separation + cellsize
	if max_width != 0:
		obj_diff = max_width/childs_list.size()
		obj_diff = min(obj_diff, cellsize)
	
	var left_position = (childs_list.size() - 1) * (obj_diff/-2)
	var index = (pos - left_position)/obj_diff + 1
	index = max(0, min(index, childs_list.size()-1))
	return index
