extends Node2D

signal points_overloaded

@export var MAX_POINTS:int = 31

const _card_path = preload("res://game/card/card.tscn")

var _card_list:Array[CardData] = []
var _points = 0

@onready var stack_points = $stack_points
@onready var cards_root = $cards_root

func _ready():
	pass


func _add_card(card_data:CardData):
	var new_card = _card_path.instantiate()
	cards_root.add_child(new_card)
	new_card.set_card_values(card_data)
	new_card.rotation = randf() - 0.5
	var pos = Vector2(randi()%20-10 - 34, randi()%20-10 - 50)
	new_card.position = pos
#	new_card.set_card_inactive()
	animate_card_add(new_card)
	_card_list.append(card_data)
	
	_points += card_data.value
	_points = max(_points, 0)
	
	if MAX_POINTS < _points:
#		emit_signal("points_overloaded")
		_points = 0
	stack_points.text = str(_points)

func animate_card_add(card:Object) -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	card.modulate = Color(1,1,1,0)
	tween.tween_property(card, "modulate", Color(1,1,1,1), 0.1)
	
	var angle = card.rotation_degrees
	card.rotation_degrees = angle - (randi()%90 - 45)
	tween.tween_property(card, "rotation_degrees", angle, 0.3)
	
	card.scale = Vector2(1.11, 1.11)
	tween.tween_property(card, "scale", Vector2(1,1), 0.3)
#	tween.tween_callback(_on_card_added).set_delay(0.2)


func on_deck_ended():
	var childs = cards_root.get_children()
	for card in childs:
		card.queue_free()


func get_current_points()->int:
	return _points
