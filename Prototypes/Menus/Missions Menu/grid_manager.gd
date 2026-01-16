extends Node2D

@export var columns : int = 5
@export var steps : int = 10

var mission_button : PackedScene = preload("res://Prototypes/Menus/Missions Menu/mission_button.tscn")

@onready var grid_container: GridContainer = $GridContainer
@onready var columns_container: HBoxContainer = $Columns
@onready var steps_container: VBoxContainer = $Steps

func _ready() -> void:
	instanciate_grid()

func instanciate_grid() -> void:
	grid_container.columns = columns

	for i in (steps*columns):
		var button_instance = mission_button.instantiate()
		button_instance.custom_minimum_size.x = 50
		button_instance.custom_minimum_size.y = 50
		grid_container.add_child(button_instance)
	
	for i in columns:
		var column_instance = mission_button.instantiate()
		column_instance.name = str(i+1)
		column_instance.custom_minimum_size.x = 50
		column_instance.custom_minimum_size.y = 50
		columns_container.add_child(column_instance)
		
	for i in steps:
		var step_instance = mission_button.instantiate()
		step_instance.name = str(i+1)
		step_instance.custom_minimum_size.x = 50
		step_instance.custom_minimum_size.y = 50
		steps_container.add_child(step_instance)
	
	await get_tree().process_frame
	
	for i in grid_container.get_children():
		get_coordinates(i)
		i.name = str(i.my_x) + "/" + str(i.my_y)
		
	get_tree().queue_delete(columns_container)
	get_tree().queue_delete(steps_container)
	
func get_coordinates(item : Node) -> void:
	
	for i in columns_container.get_children():
		if i.position.x == item.position.x:
			item.my_x = int(i.name)
			break
		else:
			pass

	for i in steps_container.get_children():
		if i.position.y == item.position.y:
			item.my_y = int(i.name)
			break
		else:
			pass

func hide_cell(cell : Node) -> void:
	cell.modulate = Color8(0, 0, 0, 0)
	cell.disabled = true
	cell.mouse_filter = 2
