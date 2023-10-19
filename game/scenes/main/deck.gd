extends Node2D


class_name Deck

const CARD_ANIM_TIME = 0.3

var _decklist:Array = []
var _deck:Array = []


var card = preload("res://game/card/card.tscn")


func _ready():
#	_generate()
	pass


#func _generate():
#	for value in Common.card_names:
#		for suit in Common.SUITES:
#			_decklist.append(CardData.new(Common.SUITES[suit], value))


func shuffle():
	shuffle_from_cardlist(_deck)


func shuffle_from_cardlist(cardlist: Array):
	if cardlist.is_empty():
		cardlist = _decklist
	
	var counter = 0
	var rgt_v = len(cardlist)
	while counter < rgt_v:
		counter += 1
		var random_idx = randi()%(cardlist.size())
		var random_card = cardlist[random_idx]
		cardlist.remove_at(random_idx)
		_deck.append(random_card)
	$spr_deck.visible = true


func get_cards_count() -> int:
	return len(_deck)


func get_top_card():
	return _deck.front()


func remove_top_card(direction:Vector2):
	var anim_card = card.instantiate()
	add_child(anim_card)
	anim_card.set_card_as_hidden(true)
	anim_card.set_card_values(Common.SUITES.Clubs, "A")
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(anim_card, "position", direction * -100, CARD_ANIM_TIME)
	tween.tween_property(anim_card, "rotation_degrees", -60, CARD_ANIM_TIME)
	tween.tween_property(anim_card, "modulate", Color(1, 1, 1, 0), CARD_ANIM_TIME)
	tween.tween_callback(anim_card.queue_free).set_delay(CARD_ANIM_TIME)
	
	_deck.remove_at(0)
	
	if len(_deck) == 0:
		$spr_deck.visible = false
