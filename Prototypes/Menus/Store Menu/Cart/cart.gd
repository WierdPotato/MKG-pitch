extends Control

const cart_button = preload("uid://cm7gyweejfo7x")
@onready var list_container: VBoxContainer = $ScrollContainer/VBoxContainer


func update_cart():
	for i in STORE.cart:
		var instance_button = cart_button.instantiate()
		instance_button.name = "Button " + str(i.Name)
		list_container.add_child(instance_button)
		instance_button.manage_info(i)
