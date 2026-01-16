extends HBoxContainer

signal disable_load
signal enable_load

signal disable_more
signal enable_more

signal disable_less
signal enable_less

signal disable_empty
signal enable_empty

signal disable_max
signal enable_max

@onready var x_1: Button = $HBoxAmmounts/x1
@onready var x_10: Button = $HBoxAmmounts/x10
@onready var x_100: Button = $HBoxAmmounts/x100

@onready var less: Button = $HBoxSelector/Less
@onready var more: Button = $HBoxSelector/More
@onready var label: Label = $HBoxSelector/Label
@onready var load_button: Button = $Load
@onready var max_button: Button = $Max
@onready var empty: Button = $Empty


var selected_ammo : int 
var increments

func _ready() -> void:
	increments = 1
	selected_ammo = 0
	only_buttons(x_1)

func only_buttons(button) -> void:
	var buttons : Array = [x_1, x_10, x_100]
	var disabled_buttons : Array = []
	
	if button:
		disabled_buttons = buttons
		disabled_buttons.erase(button)
		button.disabled = true
		for i in disabled_buttons:
			i.disabled = false
		disabled_buttons.clear()
	else:
		pass

func _on_x_1_pressed() -> void:
	increments = 1
	only_buttons(x_1)


func _on_x_10_pressed() -> void:
	increments = 10
	only_buttons(x_10)


func _on_x_100_pressed() -> void:
	increments = 100
	only_buttons(x_100)

func check_less() -> void:
	if PREP.ship_ammo <= 0 or empty.disabled or selected_ammo + PREP.ship_ammo <= 0:
		emit_signal("disable_less")
	else:
		emit_signal("enable_less")

func _on_less_pressed() -> void:
	selected_ammo -= increments

func _on_enable_less() -> void:
	less.disabled = false

func _on_disable_less() -> void:
	less.disabled = true

func check_more() -> void:
	if PREP.ship_ammo + selected_ammo >= PREP.ship_max_ammo or selected_ammo >= PREP.inventory_ammo or max_button.disabled:
		emit_signal("disable_more")
	else:
		emit_signal("enable_more")

func _on_disable_more() -> void:
	more.disabled = true

func _on_enable_more() -> void:
	more.disabled = false

func _on_more_pressed() -> void:
	selected_ammo += increments

func check_max() -> void:
	var ammo_left = PREP.ship_max_ammo - PREP.ship_ammo
	if ammo_left <= 0:
		emit_signal("disable_max")
	else:
		emit_signal("enable_max")

func _on_max_pressed() -> void:
	var ammo_left = PREP.ship_max_ammo - PREP.ship_ammo
	
	if ammo_left >= PREP.inventory_ammo:
		selected_ammo = PREP.inventory_ammo
	else:
		selected_ammo = ammo_left

func _on_disable_max() -> void:
	max_button.disabled = true

func _on_enable_max() -> void:
	max_button.disabled = false

func check_empty() -> void:
	if PREP.ship_ammo == 0:
		emit_signal("disable_empty")
	else:
		emit_signal("enable_empty")

func _on_empty_pressed() -> void:
	if PREP.ship_ammo > 0:
		selected_ammo = -PREP.ship_ammo
	else: 
		pass

func _on_disable_empty() -> void:
	empty.disabled = true

func _on_enable_empty() -> void:
	empty.disabled = false

func check_load() -> void:
	if selected_ammo + PREP.ship_ammo > PREP.ship_max_ammo or selected_ammo > PREP.inventory_ammo or selected_ammo + PREP.ship_ammo < 0:
		emit_signal("disable_load")
	else:
		emit_signal("enable_load")

func _on_load_pressed() -> void:
	PREP.ship_ammo += selected_ammo
	PREP.inventory_ammo -= selected_ammo
	selected_ammo = 0

func _on_disable_load() -> void:
	load_button.disabled = true

func _on_enable_load() -> void:
	load_button.disabled = false

func _process(_delta: float) -> void:
	label.text = str(selected_ammo)
	check_empty()
	check_max()
	check_more()
	check_less()
	check_load()
