extends PanelContainer

class_name BaseCard

signal card_interacted(index: int)

@onready var race = $CardState/Race
@onready var card_name = $CardState/Name
@onready var value = $CardState/Value
@onready var texture_rect = $CardState/TextureRect

var _show_back = false
var _back_texture = preload("res://assets/sprites/cards/backs/Back1.png")


func set_card_values(card_data:CardData):
	texture_rect.texture = card_data.texture
	race.text = card_data.race.name
	card_name.text = card_data.name
	value.text = str(card_data.value)


func _on_back_gui_input(event):
	if event is InputEventMouseButton and\
			event.button_index == MOUSE_BUTTON_LEFT and\
			event.is_pressed():
		print(get_index())
		card_interacted.emit(get_index())
