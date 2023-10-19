extends Node2D


func get_card_to_play(hand:Array, points:int):
	await get_tree().create_timer(1).timeout
	return randi()%len(hand)
