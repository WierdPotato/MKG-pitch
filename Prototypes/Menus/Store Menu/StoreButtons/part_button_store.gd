extends Button

@onready var button_name: Label = $Name
@onready var stats_value: HBoxContainer = $StatsValue

@onready var area: Label = $StatsValue/Area
@onready var weight: Label = $StatsValue/Weight
@onready var velocity: Label = $StatsValue/Velocity
@onready var power: Label = $StatsValue/Power
@onready var health: Label = $StatsValue/Health
@onready var carga: Label = $StatsValue/Load
@onready var damage: Label = $StatsValue/Damage
@onready var cadence: Label = $StatsValue/Cadence
@onready var rounds: Label = $StatsValue/Rounds
@onready var tamaño: Label = $StatsValue/Size
@onready var price: Label = $StatsValue/Price

var my_part
var selected :bool = false

func manage_info(part):
	my_part = part
	button_name.text = str(part.Name)
	price.text = "PRICE: " + str(part.Price)
	self.custom_minimum_size.y = 80
	area.text = edit_text(part.Area)
	weight.text = edit_text(part.Weight)
	velocity.text = edit_text(part.Speed)
	power.text = edit_text(part.Force)
	health.text = edit_text(part.HP)
	carga.text = edit_text(part.Capacity)
	damage.text = edit_text(part.Damage)
	cadence.text = edit_text(part.Cadence)
	rounds.text = edit_text(part.Rounds)
	tamaño.text = edit_text(part.Size)
	price.text = edit_text(part.Price)
	
func edit_text(value) -> String:
	var final_value
	if value == 0:
		final_value = "-"
	else:
		final_value = str(value)
	return final_value

func do_selected() -> void:
	selected = true
	var stylebox : StyleBoxFlat = $".".get_theme_stylebox("normal")
	stylebox.bg_color = Color8(13, 82, 181, 78)
	STORE.part_selected(my_part)
	
func do_deselected() -> void:
	selected = false
	var stylebox : StyleBoxFlat = $".".get_theme_stylebox("normal")
	stylebox.bg_color = Color8(27, 104, 104, 86)
	STORE.part_deselected(my_part)

func do_empty_deselect() -> void:
	selected = false
	var stylebox : StyleBoxFlat = $".".get_theme_stylebox("normal")
	stylebox.bg_color = Color8(27, 104, 104, 86)
	
func _on_pressed() -> void:
	#print(self)
	if selected:
		do_deselected()
	else:
		do_selected()

func _on_mouse_entered() -> void:
	STORE.preview_part(my_part)
