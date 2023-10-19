extends Node


signal card_played(card_data:CardData)


func on_card_played(card_data:CardData):
	card_played.emit(card_data)
