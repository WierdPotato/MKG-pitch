extends Node2D

@export var prep_menu : PackedScene

@onready var store: Control = $Store
@onready var total_price_text: Label = $TotalPrice
@onready var ammo_buyer: HBoxContainer = $AmmoBuyer
@onready var wallet: Label = $Wallet
@onready var buy: Button = $Buy

var total_price : int

func _on_buy_pressed() -> void:
	STORE.buy()
	ammo_buyer.bought()
	store.get_child(0).deselect_all()

func _on_prep_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Prototypes/Menus/Prep Menu/Prep Menu.tscn")

func _process(_delta: float) -> void:
	total_price = STORE.selected_total_price + ammo_buyer.total_cost
	total_price_text.text = "TOTAL PRICE: " + str(total_price) 
	wallet.text = "WALLET: " + str(GLOBAL.money)
	
	if total_price > GLOBAL.money:
		buy.disabled = true
	else:
		buy.disabled = false
