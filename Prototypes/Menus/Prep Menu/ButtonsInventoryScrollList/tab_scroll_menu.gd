extends ScrollContainer

@onready var container: VBoxContainer = $MarginContainer/VBoxContainer

var button_template = preload("res://Prototypes/Menus/Prep Menu/InventoryButton/part_button.tscn")


func _ready() -> void:
	pass

func add_buttons(parts : Array) -> void:
	for i in parts:
		var instance_button = button_template.instantiate()
		instance_button.name = "Button " + str(i.Name)
		container.add_child(instance_button)
		instance_button.manage_info(i)
		#instance_button.get_child(2).text = "AMMOUNT: " 
	pass
