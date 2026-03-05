extends Node2D

@export var prep_menu : PackedScene

@onready var all_filter: TextureButton = $Store/Tabs/All/AllButton
@onready var store: Control = $Store
@onready var parts_list: Control = $Store/PartsList
@onready var total_price_text: Label = $TotalPrice
@onready var buy: TextureButton = $Purchase/PurchaseButton
@onready var wallet: Label = $Wallet/Text
@onready var ammo: Node2D = $Ammo
@onready var cart_value: Label = $Cart/Value

var total_price : int
var current_selected_button

var current_part_price = 0
var disable_purchase : bool

func _ready() -> void:
	all_filter.grab_focus()
	store.tab_id = 0
	disable_purchase = true

func _on_tree_entered() -> void:
	print("Store on tree entered")
	STORE.on_ready()

func deselect_prev_button(button : TextureButton)-> void:
	if current_selected_button:
		if current_selected_button != button:
			current_selected_button.deselect_button()
			
	current_selected_button = button

func _on_purchase_button_pressed() -> void:
	current_part_price = 0
	disable_purchase = true
	STORE.buy()
	parts_list.prepare_list()

func _on_prep_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Prototypes/Shmup/Demo/PrepMenuDemo.tscn")

func update_cart_price()-> void:
	cart_value.text = str(current_part_price + ammo.price) 


func _process(_delta: float) -> void:
	#total_price = STORE.selected_total_price + ammo_buyer.total_cost
	total_price_text.text = "TOTAL PRICE: " + str(total_price) 
	wallet.text = str(GLOBAL.money)
	update_cart_price()
	if current_part_price + ammo.price > GLOBAL.money or disable_purchase:
		buy.disabled = true
		
	else:
		buy.disabled = false
