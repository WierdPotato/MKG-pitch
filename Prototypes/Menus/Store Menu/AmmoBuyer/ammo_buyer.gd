extends HBoxContainer


@onready var x_1_unit: Button = $HBoxAmmounts/x1Unit
@onready var x_10_unit: Button = $HBoxAmmounts/x10Unit
@onready var x_100_unit: Button = $HBoxAmmounts/x100Unit

@onready var less: Button = $HBoxSelector/Less
@onready var more: Button = $HBoxSelector/More
@onready var selected_ammo: Label = $HBoxSelector/SelectedAmmo

@onready var confirm: Button = $Confirm

@export var round_price : int 

var selected_ammo_int : int

var increments : int
var total_cost : int

func _ready() -> void:
	increments = 1
	
	disable_buttons(x_1_unit)

func disable_buttons(button) -> void:
	var buttons : Array = [x_1_unit, x_10_unit, x_100_unit]
	var disabled_buttons : Array = []
	if GLOBAL.money < total_cost:
		disabled_buttons.append(confirm)
		disabled_buttons.append(more)
		for i in disabled_buttons:
			i.disabled = true
		disabled_buttons.clear()
		
	else:
		disabled_buttons.append(confirm)
		disabled_buttons.append(more)
		for i in disabled_buttons:
			i.disabled = false
		disabled_buttons.clear()
	
	if selected_ammo_int == 0:
		less.disabled = true
	
	else:
		less.disabled = false
		
	if button:
		disabled_buttons = buttons
		disabled_buttons.erase(button)
		button.disabled = true
		for i in disabled_buttons:
			i.disabled = false
		disabled_buttons.clear()
	else:
		pass

func manage_total_cost() -> void:
	total_cost = selected_ammo_int * round_price

func _on_x_1_unit_pressed() -> void:
	increments = 1
	disable_buttons(x_1_unit)
	
func _on_x_10_unit_pressed() -> void:
	increments = 10
	disable_buttons(x_10_unit)
	
func _on_x_100_unit_pressed() -> void:
	increments = 100
	disable_buttons(x_100_unit)
	
func _on_less_pressed() -> void:
	selected_ammo_int -= increments

func _on_more_pressed() -> void:
	selected_ammo_int += increments

func bought() -> void:
	PREP.inventory_ammo += selected_ammo_int
	selected_ammo_int = 0
	
func _process(_delta: float) -> void:
	selected_ammo.text = str(selected_ammo_int)
	manage_total_cost()
	disable_buttons(null)
