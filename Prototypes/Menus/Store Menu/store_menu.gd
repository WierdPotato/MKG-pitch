extends Node2D

@export var prep_menu : PackedScene

@onready var all_filter: TextureButton = $Store/Tabs/All/AllButton
@onready var store: Control = $Store
@onready var parts_list: Control = $Store/PartsList
@onready var total_price_text: Label = $TotalPrice
@onready var buy: TextureButton = $Purchase/PurchaseButton
@onready var wallet: Label = $wallet
@onready var ammo: Node2D = $Ammo

var total_price : int
var current_selected_button

func _ready() -> void:
	all_filter.grab_focus()
	store.tab_id = 0

func _on_tree_entered() -> void:
	print("Store on tree entered")
	STORE.on_ready()

func deselect_prev_button(button : TextureButton)-> void:
	if current_selected_button:
		if current_selected_button != button:
			current_selected_button.deselect_button()
			
	current_selected_button = button

func _on_purchase_button_pressed() -> void:
	STORE.buy()
	parts_list.prepare_list()

func _on_prep_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Prototypes/Shmup/Demo/PrepMenuDemo.tscn")

func _process(_delta: float) -> void:
	#total_price = STORE.selected_total_price + ammo_buyer.total_cost
	total_price_text.text = "TOTAL PRICE: " + str(total_price) 
	wallet.text = "WALLET: " + str(GLOBAL.money)
	
	if total_price + ammo.price > GLOBAL.money:
		buy.disabled = true
		
	else:
		buy.disabled = false
