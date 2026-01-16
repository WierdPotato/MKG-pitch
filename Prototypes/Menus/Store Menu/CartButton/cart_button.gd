extends Button

@onready var part_name: Label = $HBoxContainer/Name
@onready var ammount_value: Label = $HBoxContainer/VBoxContainer/Ammount/AmmountValue
@onready var price_value: Label = $HBoxContainer/VBoxContainer/Price/PriceValue


var ammount : int
var my_part

func _ready() -> void:
	custom_minimum_size.x = 545
	custom_minimum_size.y = 75
	ammount = 1
	
func manage_info(part):
	my_part = part
	part_name.text = part.Name
	price_value.text = str(part.Price)
	pass

func _on_less_pressed() -> void:
	ammount -= 1
	STORE.quit_from_cart(my_part)
	if ammount <= 0:
		get_tree().queue_delete(self)
		
	print(ammount)
	
func _on_more_pressed() -> void:
	print(ammount)
	ammount += 1
	STORE.add_part_to_cart(my_part)
	print(ammount)

func _process(_delta: float) -> void:
	ammount_value.text = str(ammount)
