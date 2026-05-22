extends TextureButton

@onready var planet_map : String = "res://Prototypes/Menus/Planet/PlanteStageMenu.tscn"


const halos_spritesheet = preload("uid://cp6h1rgu48ji2")
const normal_spritesheet = preload("uid://8yv3h7mhvswa")

var missions_menu: Node2D 

var my_details : Dictionary

var my_map_coords : Vector2

func set_info(details : Dictionary)->void:
	my_details = details
	var region_dict = my_details.get("texture_region")
	var texture_region : Rect2 = Rect2(region_dict.get("x"), region_dict.get("y"), region_dict.get("w"), region_dict.get("h"))
	texture_normal.set_region(texture_region)
	
func _on_button_pressed() -> void:
	print(my_details)
	PREP.selected_planet_id = my_details.get("name")
	GLOBAL.planet_menu_prev_scene = "system"
	get_tree().change_scene_to_file(planet_map)
