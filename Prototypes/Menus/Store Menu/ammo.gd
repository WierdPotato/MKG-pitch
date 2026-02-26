extends Node2D

signal disable_more
signal enable_more

signal disable_less
signal enable_less

signal disable_buy
signal enable_buy

@onready var toggle: TextureButton = $Buyer/Toggle/Toggle
@onready var less: TextureButton = $Buyer/Less/Less
@onready var more: TextureButton = $Buyer/More/More
@onready var label: Label = $Buyer/Counter/Label
@onready var buy_button: TextureButton = $Buyer/BuyAmmo/Buy

@onready var hundred: Label = $Buyer/Toggle/Hundred
@onready var tens: Label = $Buyer/Toggle/Tens
@onready var ones: Label = $Buyer/Toggle/Ones

@onready var loaded: Label = $Info/Loaded
@onready var available: Label = $Info/Available

@export var ammo_price : int

var selected_ammo : int 
var increments
var highlight_font : Color = ("#1A1C2C")
var normal_font : Color = ("#F4F4F4")

var price : int

func _ready() -> void:
	ones.add_theme_color_override("font_color", highlight_font)
	ones.add_theme_color_override("font_outline_color", highlight_font)
	increments = 1
	selected_ammo = 0
	PREP.sim_ship_ammo += selected_ammo
	PREP.simulate_stats()

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
	if selected_ammo > 0:
		emit_signal("enable_less")
	else:
		emit_signal("disable_less")

func _on_less_pressed() -> void:
	selected_ammo -= increments

func _on_enable_less() -> void:
	less.disabled = false

func _on_disable_less() -> void:
	less.disabled = true

func check_more() -> void:
	if price > GLOBAL.money:
		emit_signal("disable_more")
	else:
		emit_signal("enable_more")

func _on_disable_more() -> void:
	more.disabled = true

func _on_enable_more() -> void:
	more.disabled = false

func _on_more_pressed() -> void:
	selected_ammo += increments

func _on_buy_pressed() -> void:
	PREP.inventory_ammo += selected_ammo
	GLOBAL.money -= price
	selected_ammo = 0

func check_buy() -> void:
	if price > GLOBAL.money:
		emit_signal("disable_buy")
	else:
		emit_signal("enable_buy")
		
func _on_disable_buy() -> void:
	buy_button.disabled = true

func _on_enable_buy() -> void:
	buy_button.disabled = false

func _process(_delta: float) -> void:
	price = selected_ammo * ammo_price
	available.text = str(PREP.inventory_ammo)
	loaded.text = str(PREP.ship_ammo)
	label.text = str(selected_ammo)
	check_more()
	check_less()
	check_buy()
