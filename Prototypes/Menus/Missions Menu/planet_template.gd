extends Node2D

@onready var button: Button = $Button
@onready var planet_sprite: Sprite2D = $Sprite2D

@onready var planet_map : String = "res://Prototypes/Menus/Planet/PlanteStageMenu.tscn"
@onready var hold_timer: Timer = $HoldTimer


const halos_spritesheet = preload("uid://cp6h1rgu48ji2")
const normal_spritesheet = preload("uid://8yv3h7mhvswa")

var range_ring : TextureCircle
var missions_menu: Node2D 

var my_details : Dictionary
var star_coords : Vector2
var my_map_coords : Vector2
var distance_to_star 

var distances : Dictionary = {}

func set_info(details : Dictionary)->bool:
	my_details = details
	var region_dict = my_details.get("texture_region")
	var texture_region : Rect2 = Rect2(region_dict.get("x"), region_dict.get("y"), region_dict.get("w"), region_dict.get("h"))
	planet_sprite.texture.set_region(texture_region)
	button.scale = Vector2(my_details.get("button_scale"), my_details.get("button_scale"))
	distance_to_star = abs((star_coords-my_map_coords).length())
	my_details.set("distance_star", distance_to_star)
	print("Name: ", my_details.get("name")," / Distance: ", my_details.get("distance_star"))
	return true

func recover_info(details : Dictionary)->bool:
	my_details = details
	var region_dict = my_details.get("texture_region")
	var texture_region : Rect2 = Rect2(region_dict.get("x"), region_dict.get("y"), region_dict.get("w"), region_dict.get("h"))
	planet_sprite.texture.set_region(texture_region)
	button.scale = Vector2(my_details.get("button_scale"), my_details.get("button_scale"))
	print("Name: ", my_details.get("name")," / Distance: ", my_details.get("distance_star"))
	return true

func add_distances(planet:Dictionary, coords:Vector2)->void:
	var planet_name = planet.get("name")
	var distance = abs((coords-my_map_coords).length())
	distances.get_or_add(planet_name)
	distances.set(planet_name, distance)

func check_focused()->void:
	if PLANETS.last_focused_planet == my_details.get("name"):
		button.grab_focus()

func check_location()->void:
	if PLANETS.current_location == my_details.get("name"):
		range_ring.global_position = global_position


func _on_button_focus_entered() -> void:
	PLANETS.last_focused_planet = my_details.get("name")
	halo_planet()

func _on_button_focus_exited() -> void:
	normal_planet()

func _on_button_mouse_entered() -> void:
	PLANETS.last_focused_planet = my_details.get("name")
	halo_planet()

func _on_button_mouse_exited() -> void:
	normal_planet()

func halo_planet()->void:
	planet_sprite.texture.set_atlas(halos_spritesheet)

func normal_planet()->void:
	planet_sprite.texture.set_atlas(normal_spritesheet)

func _on_button_button_down() -> void:
	#hold_timer.start(5)
	pass

func _on_button_button_up() -> void:
	pass # Replace with function body.

func _on_button_pressed() -> void:
	apply_button()
	pass

func apply_button()->void:
	print(my_details)
	print(distances)
	PREP.selected_planet_id = my_details.get("name")
	GLOBAL.planet_menu_prev_scene = "system"
	get_tree().change_scene_to_file(planet_map)
