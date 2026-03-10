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
@onready var pause_menu: Control = $PauseMenu


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

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("Back"):
		if !pause_menu.visible:
			go_to_prep()

func _on_pause_menu_visibility_changed() -> void:
	if pause_menu.visible == true:
		pass
	else:
		all_filter.grab_focus()


func _on_pause_pressed() -> void:
	pause_menu.opened("store")

func _on_prep_button_pressed() -> void:
	go_to_prep()

func go_to_prep() -> void:
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
