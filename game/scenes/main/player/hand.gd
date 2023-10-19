extends Node2D

#signal card_played(card_data:CardData)

@onready var container = $Container
@onready var placeholder = $Placeholder
@onready var card_draggable = $card_draggable


var card_path = preload("res://game/card/card.tscn")
var card_list:Array[CardData] = []
var _dragged_card_index:int = -1
var _card_start_y_position:float = 0
var _is_on_drop_area:bool = false
const _MAX_DRAG_DIFF = 35

func _physics_process(delta):
	if _dragged_card_index == -1:
		return
	
	card_draggable.global_position = get_global_mouse_position() - Vector2(34, 50)
	
	if abs(_card_start_y_position - card_draggable.global_position.y) < _MAX_DRAG_DIFF:
		var index = container.get_child_index_by_position(card_draggable.global_position.x)
		var childs_list = container.get_children()
		var card_object = childs_list[_dragged_card_index]
		
		var tmp = card_list[_dragged_card_index]
		card_list[_dragged_card_index] = card_list[index]
		card_list[index] = tmp
		
		_dragged_card_index = index
		container.move_child(card_object, index)


func _input(event:InputEvent):
	if _dragged_card_index != null:
		if event is InputEventMouseButton and\
			event.button_index == MOUSE_BUTTON_LEFT and\
			!event.is_pressed():
			
			_on_card_dragdropg()

func add_card(card_data:CardData, card_position:int = -1):
	var new_card = card_path.instantiate()
	container.add_child(new_card)
	new_card.set_card_values(card_data)
	new_card.connect("card_interacted", _on_card_started_drag)
	
	if card_position > -1:
		container.move_child(new_card, card_position)
	
	card_list.append(card_data)

func remove_card(index:int):
	var childs_list = container.get_children()
	childs_list[index].queue_free()

func _on_card_started_drag(index:int):
	if _dragged_card_index == null:
		return
	var childs_list = container.get_children()
	var card_object = childs_list[index]
	_card_start_y_position = card_object.global_position.y
	card_object.hide()
	
	_dragged_card_index = index
	card_draggable.set_card_values(card_list[index])
	card_draggable.show()
	
func _on_card_dragdropg():
	card_draggable.hide()
	var childs_list = container.get_children()
	var card_object = childs_list[_dragged_card_index]

	if _is_on_drop_area:
		card_object.queue_free()
		SignalBus.card_played.emit(card_list[_dragged_card_index])
		card_list.remove_at(_dragged_card_index)
		
	else:
		card_object.show()
	_dragged_card_index = -1
	_is_on_drop_area = false


func set_placeholder_position(index:int):
	if placeholder not in container.get_children():
		container.add_child(placeholder)
	container.move_child(placeholder, index)


func _on_card_area_entered(area):
	if area.name == "drop_area":
		_is_on_drop_area = true

func _on_card_area_exited(area):
	if area.name == "drop_area":
		_is_on_drop_area = false
