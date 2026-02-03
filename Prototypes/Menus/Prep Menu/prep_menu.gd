extends Node2D

@onready var inventory_ammo: Label = $Elements/InventoryAmmo
@onready var loaded_ammo: Label = $Elements/LoadedAmmo

func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Prototypes/Shmup/FightLevel/fight_level.tscn")

func _on_equip_pressed() -> void:
	PREP.parts_changed()

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://Prototypes/Menus/Store Menu/StoreMenu.tscn")

func _process(_delta: float) -> void:
	inventory_ammo.text = "AVAILABLE AMMO: " + str(PREP.inventory_ammo)
	loaded_ammo.text = "LOADED AMMO: " + str(PREP.ship_ammo)
