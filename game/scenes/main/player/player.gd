extends Node2D

signal card_added


@onready var _hand = $Hand

var _ai_players:Array = []
var _is_ai:bool = false
var _cards:Array = []
var _turn_maker


func _ready():
#	_hand.connect("card_play", self._on_card_added)
	_ai_players.append(preload("res://scenes/EasyAI.tscn"))
	SignalBus.connect("card_played", _on_card_played)
	pass


func set_player_as_enemy():
	_is_ai = true
	_turn_maker = _ai_players[randi()%len(_ai_players)].instantiate()
	add_child(_turn_maker)


func add_card_in_hand(card_data:CardData) -> Node2D:
	_cards.append(card_data)
	return $Hand.add_card(card_data)


func _on_card_played(card:BaseCard):
	for d in _cards:
		if d._suit == card._suite && d._name == card._value:
			_cards.remove_at(_cards.find(d))
			return


func has_card_in_hand(card_data:CardData) -> bool:
	for d in _cards:
		if d._suit == card_data._suit && d._name == card_data._name:
			return true
	
	return false


func lose_stick():
	$Sticks.add_stick()


func get_cards_count()->int:
	return len(_cards)


func _on_card_added():
	emit_signal("card_added")


func make_turn(points:int):
	if _turn_maker and _is_ai:
		var card_id = await _turn_maker.get_card_to_play(_cards, points)
		_hand.play_card(card_id)
