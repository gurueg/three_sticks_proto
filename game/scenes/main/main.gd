extends Node2D

var all_cards: Array[CardData]


#func _ready():
#	var dir = DirAccess.get_directories_at("res://game/card/cards")
#	for dir_path in dir:
#		for file_name in DirAccess.get_files_at("res://game/card/cards/%s" % dir_path):
#			if file_name.get_extension() == "tres":  
#				all_cards.append(load(file_name))


#
#signal deck_ended
#signal card_played
#
#
#const HANDS_ROTATION = {
#	2: [0, 180],
#	3: [0, 90, -90],
#	4: [0, 90, 180, -90],
#}
#const START_HAND_SIZE = 2
#
#
#var _discard_list = []
#var _players:Array = []
#var _main_player
#var _current_player_id = -1
#
#
#var _current_player_to_add_card:int = 0
#var _is_started_process:bool = false
#
@export var PLAYERS_COUNT = 3
#
#
#@onready var _player_hand = $HandsObjects/PlayerHand
@onready var _stack = $Stack
#@onready var _deck = $Deck
#@onready var HANDS_POSITIONS = {
#	2: [Vector2(0, get_viewport().get_size().y/2), Vector2(0, -get_viewport().get_size().y/2)],
#	3: [Vector2(0, get_viewport().get_size().y/2), Vector2(-get_viewport().get_size().x/2, 0), Vector2(get_viewport().get_size().x/2, 0)],
#	4: [Vector2(0, get_viewport().get_size().y/2), Vector2(-get_viewport().get_size().x/2, 0), Vector2(0, -get_viewport().get_size().y/2), Vector2(get_viewport().get_size().x/2, 0)],
#}
#
var _player = preload("res://game/scenes/main/player/player.tscn")
@onready var _players_places = [$Player1]
#
func _ready():
	SignalBus.card_played.connect(_play_card)
#	for i in range(PLAYERS_COUNT):
	var new_player = _player.instantiate()
#		_players.append(new_player)
	_players_places[0].add_child(new_player)
	
	
	var dir = DirAccess.get_directories_at("res://game/card/cards")
	for dir_path in dir:
		for file_name in DirAccess.get_files_at("res://game/card/cards/%s" % dir_path):
			if file_name.get_extension() == "tres":  
				all_cards.append(load("res://game/card/cards/%s/%s" % [dir_path, file_name]))
#		new_player.connect("card_added", _on_card_added)
#		new_player.position = HANDS_POSITIONS[PLAYERS_COUNT][i]
#		new_player.rotation_degrees = HANDS_ROTATION[PLAYERS_COUNT][i]
#
#	_main_player = _players[0]
#	for p in _players:
#		if p != _main_player:
#			p.set_player_as_enemy()
#
#	_deck.shuffle()
	_fill_user_hands(new_player)
#
#	_current_player_id = 0
#	_stack.connect("points_overloaded", _on_points_overloaded)
#	SignalBus.connect("card_pressed", _try_to_play_card)
#
#	connect("card_played", SignalBus.on_card_played)
#	SignalBus.connect("card_played", _play_card)
#
#
func _fill_user_hands(new_player):
#	if _players[_current_player_to_add_card].get_cards_count() == 4:
#		_is_started_process = true
#		return
#
#	var player = _players[_current_player_to_add_card]
	for i in all_cards:
		new_player.add_card_in_hand(i)
#	var direction:Vector2 = _deck.position - player.position
#	_deck.remove_top_card(direction.normalized())
#
#	_current_player_to_add_card = (_current_player_to_add_card + 1)%len(_players)
#
#
#func _try_to_play_card(card:BaseCard):
#	if !_is_started_process:
#		return
#
#	var current_player = _players[_current_player_id]
#	var card_data = Common.CardData.new(card._suite, card._value)
#	if current_player.has_card_in_hand(card_data):
#		emit_signal("card_played", card)
#
#
func _play_card(card_data:CardData):
	_stack._add_card(card_data)
#	var current_player = _players[_current_player_id]
#	var card_data = Common.CardData.new(card._suite, card._value)
#	#TODO: add function in player class, delete card in hand there
##	current_player.play_card(card_id)
##	card.queue_free()
#
#	if _deck.get_cards_count() == 0:
#		emit_signal("deck_ended")
#		_deck.shuffle_from_cardlist(_discard_list)
#
#	_stack.on_card_played(card_data)
#	_discard_list.append(card_data)
##	current_player.remove_card_from_hand(card_data)
#
##TODO: add as function put_card_in_hand
#	var added_card = current_player.add_card_in_hand(_deck.get_top_card())
#	var direction:Vector2 = _deck.position - current_player.position
#	_deck.remove_top_card(direction.normalized())
#
#
#func _on_points_overloaded():
#	var current_player = _players[_current_player_id]
#	current_player.lose_stick()
#
#
#func _on_card_added():
#	if _is_started_process:
#		_current_player_id += 1
#		_current_player_id %= len(_players)
#		await _players[_current_player_id].make_turn(_stack.get_current_points())
#		return
#
#	_fill_user_hands()
