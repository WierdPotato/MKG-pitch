extends ScrollContainer

@onready var container: VBoxContainer = $MarginContainer/VBoxContainer


var store_button_template = preload("res://Prototypes/Menus/Store Menu/StoreButtons/part_button_store.tscn")


func _ready() -> void:
	pass

func add_store_buttons(parts : Array) -> void:
	for i in parts:
		var instance_button = store_button_template.instantiate()
		instance_button.name = "Store Button " + str(i.Name)
		container.add_child(instance_button)
		instance_button.manage_info(i)
		#instance_button.get_child(2).text = "AMMOUNT: " 
	pass
