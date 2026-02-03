extends Control
@onready var all_filter: TextureButton = $Inventory/Tabs/All/AllButton
@onready var stats_comparator: Node2D = $StatsComparator
@onready var equiped_parts: Node2D = $ShipPreview/EquipedParts

@onready var load_progress_bar: TextureProgressBar = $ShipLoad/LoadProgressBar
@onready var load_nmb: Label = $ShipLoad/LoadNmb


@export var next_screen : PackedScene


var current_selected_button

func _ready() -> void:
	all_filter.grab_focus()
	update_load_bar()

func deselect_prev_button(button : TextureButton)-> void:
	if current_selected_button:
		if current_selected_button != button:
			current_selected_button.deselect_button()
			
	current_selected_button = button


func _on_shop_menu_pressed() -> void:
	pass # Replace with function body.

func _on_equip_pressed() -> void:
	PREP.equip_pressed()
	PREP.reset_sim()
	update_parts_label()
	update_load_bar()
	stats_comparator.update_texts()

func update_parts_label() -> void:
	equiped_parts.get_child(0).text = PREP.equiped_parts.get("bdy").get("Name")
	equiped_parts.get_child(1).text = PREP.equiped_parts.get("eng").get("Name")
	equiped_parts.get_child(2).text = PREP.equiped_parts.get("sld").get("Name")
	equiped_parts.get_child(3).text = PREP.equiped_parts.get("crg").get("Name")

func update_load_bar() -> void:
	load_progress_bar.max_value = PREP.ship_load
	load_progress_bar.value = PREP.ship_area
	load_nmb.text = str(int(lerpf(0, PREP.ship_load, PREP.ship_area))) + "%"

func _on_ready_button_pressed() -> void:
	get_tree().change_scene_to_packed(next_screen)
