extends Control

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

@onready var toggle: TextureButton = $Buttons/Toggle/Toggle

@onready var less: TextureButton = $Buttons/Less/Less
@onready var more: TextureButton = $Buttons/More/More
@onready var label: Label = $Buttons/Counter/Label
@onready var load_button: TextureButton = $Buttons/Load/Load
@onready var max_button: TextureButton = $Buttons/Max/Max
@onready var empty: TextureButton = $Buttons/Empty/Empty

@onready var hundred: Label = $Buttons/Toggle/Hundred
@onready var tens: Label = $Buttons/Toggle/Tens
@onready var ones: Label = $Buttons/Toggle/Ones

@onready var loaded: Label = $Loaded
@onready var available: Label = $Available

@onready var stats_comparator: Node2D = $"../StatsComparator"


var selected_ammo : int 
var increments
var highlight_font : Color = ("#1A1C2C")
var normal_font : Color = ("#F4F4F4")

func _ready() -> void:
	ones.add_theme_color_override("font_color", highlight_font)
	ones.add_theme_color_override("font_outline_color", highlight_font)
	increments = 1
	selected_ammo = 0
	PREP.sim_ship_ammo += selected_ammo
	PREP.simulate_stats()
	stats_comparator.update_texts()

func _on_toggle_pressed() -> void:
	if increments == 1:
		increments = 10
		change_font_color(ones, normal_font)
		change_font_color(tens, highlight_font)
	
	elif increments == 10:
		increments = 100
		change_font_color(tens, normal_font)
		change_font_color(hundred, highlight_font)

	
	elif increments == 100:
		increments = 1
		change_font_color(hundred, normal_font)
		change_font_color(ones, highlight_font)


func change_font_color(target: Label, color : Color)-> void:
	target.add_theme_color_override("font_color", color)
	target.add_theme_color_override("font_outline_color", color)

func check_less() -> void:
	if PREP.ship_ammo <= 0 or empty.disabled or selected_ammo + PREP.ship_ammo <= 0:
		if selected_ammo > 0:
			emit_signal("enable_less")
		else:
			emit_signal("disable_less")
	else:
		emit_signal("enable_less")

func _on_less_pressed() -> void:
	selected_ammo -= increments
	PREP.sim_ship_ammo = selected_ammo
	PREP.simulate_stats()
	stats_comparator.update_texts()
	
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
	PREP.sim_ship_ammo = selected_ammo
	PREP.simulate_stats()
	stats_comparator.update_texts()

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
	PREP.sim_ship_ammo = selected_ammo
	PREP.simulate_stats()
	stats_comparator.update_texts()
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
	PREP.sim_ship_ammo = selected_ammo
	PREP.simulate_stats()
	stats_comparator.update_texts()
	
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
	PREP.sim_ship_ammo = 0
	
	PREP.simulate_stats()
	PREP.update_real_stats()
	stats_comparator.update_texts()
	
func _on_disable_load() -> void:
	load_button.disabled = true

func _on_enable_load() -> void:
	load_button.disabled = false

func _process(_delta: float) -> void:
	available.text = str(PREP.inventory_ammo)
	loaded.text = str(PREP.ship_ammo)
	label.text = str(selected_ammo)
	check_empty()
	check_max()
	check_more()
	check_less()
	check_load()
