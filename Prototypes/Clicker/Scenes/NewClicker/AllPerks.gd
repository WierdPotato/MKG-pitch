extends VBoxContainer

@onready var new_clicker: Control = $".."
@onready var points_manager: Node = $"../PointsManager"

@export var real_random : bool
@export var dinamic_size : bool

@export var rows : int
@export var columns : int

@export var yellow_prob : float 
@export var red_prob : float 
@export var blue_prob : float 

@onready var row_template : PackedScene = preload("res://Prototypes/Clicker/Scenes/NewClicker/row_template.tscn")
@onready var button_template : PackedScene = preload("res://Prototypes/Clicker/Scenes/NewClicker/clicker_perks_template.tscn")

const BUBBLE_AMARILLO = preload("uid://irr0ffukfmyc")
const BUBBLE_AZUL = preload("uid://dts0x8o184n8j")
const BUBBLE_ROJO = preload("uid://cn8wu0ovcfos3")

const yellow_bought_reg : Rect2 = Rect2(0, 0, 400, 400)
const blue_bought_reg : Rect2 = Rect2(0, 408, 400, 400)
const red_bought_reg : Rect2 = Rect2(816, 408, 400, 400)

const available_reg : Rect2 = Rect2(816, 0, 400, 400) 

const yellow_pressed_reg : Rect2 = Rect2(408, 0, 400, 400)
const blue_pressed_reg : Rect2 = Rect2(408, 408, 400, 400)
const red_pressed_reg : Rect2 = Rect2(1224, 408, 400, 400)

const yellow_available_reg : Rect2 = Rect2(408, 816, 400, 400)
const blue_available_reg : Rect2 = Rect2(816, 816, 400, 400)
const red_available_reg : Rect2 = Rect2(1224, 816, 400, 400)

@onready var yellow_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/yellow_spritesheet_v1.png")
@onready var red_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/passives_spritesheet_BW_v1.png")
@onready var blue_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/blue_spritesheet_V1.1.png")

@onready var ring: Sprite2D = $"../Ring"


@onready var yellow_perk_param : Dictionary = {
	"dictionary" = GLOBAL.yellow_perks_info.duplicate(),
	"bought_reg" = yellow_bought_reg, 
	"pressed_reg" = yellow_pressed_reg,
	"available_reg" = yellow_available_reg,
	"atlas" = yellow_atlas,
	"type" = "yellow"
	
}
@onready var red_perk_param : Dictionary = {
	"dictionary" = GLOBAL.red_perks_info.duplicate(),
	"bought_reg" = red_bought_reg, 
	"pressed_reg" = red_pressed_reg,
	"available_reg" = red_available_reg,
	"atlas" = red_atlas,
	"type" = "red"
}

@onready var blue_perk_param : Dictionary = {
	"dictionary" = GLOBAL.blue_perks_info.duplicate(),
	"bought_reg" = blue_bought_reg, 
	"pressed_reg" = blue_pressed_reg,
	"available_reg" = blue_available_reg,
	"atlas" = blue_atlas,
	"type" = "blue"
}

@onready var details: Control = $"../Details"



var all_buttons : Array = []
var current_button : TextureButton
var starters : Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dinamic_size:
		set_up_rows()
	else:
		if GLOBAL.current_step == 0:
			set_up_buttons()
		else:
			recover_perks()

func set_up_rows()-> void:
	for i in rows:
		var current_row_instance = row_template.instantiate()
		add_child(current_row_instance)
		current_row_instance.name = "Fila" + str(i+1)
		for b in columns:
			var current_button_instance = button_template.instantiate()
			current_row_instance.add_child(current_button_instance)
			current_button_instance.name = "Perk" + str(b+1)
			current_button_instance.scale = Vector2(0.25, 0.25)
	
	if GLOBAL.current_step == 0:
		set_up_buttons()
	else:
		recover_perks()
	
func set_up_buttons() -> void:
	var rng = RandomNumberGenerator.new()
	var list : Array = [yellow_perk_param, red_perk_param, blue_perk_param]
	var weights = PackedFloat32Array([yellow_prob, red_prob, blue_prob])
	var hbox_iter = 1
	var yellow_count : int = 0
	var red_count : int = 0
	var blue_count : int = 0
	if real_random:
		for row in get_children():
			var iter : int = 1
			for b in row.get_children():
				var my_pick = list[rng.rand_weighted(weights)]
				var my_dict_pick = my_pick.get("dictionary").keys().pick_random()
				if my_pick.get("type") == "yellow":
					if my_pick.get("dictionary").size() == 1:
						list.erase(yellow_perk_param)
					yellow_count += 1
					
				elif my_pick.get("type") == "red":
					if my_pick.get("dictionary").size() == 1:
						list.erase(red_perk_param)
					red_count += 1
					
				else:
					if my_pick.get("dictionary").size() == 1:
						list.erase(blue_perk_param)
					blue_count += 1
					
				b.my_perk_dict = my_pick.get("dictionary").get(my_dict_pick)
				b.my_bought_region = my_pick.get("bought_reg")
				b.my_pressed_region = my_pick.get("pressed_reg")
				b.my_available_region = my_pick.get("available_reg")
				b.my_icon_atlas = my_pick.get("atlas")
				b.my_type = my_pick.get("type") 
				b.my_global_id = str(hbox_iter) + str(iter)
				var temp_dictionary : Dictionary = {
					"perk" : b.my_perk_dict, 
					"main_type" : my_pick}
				GLOBAL.picked_run_perks.get_or_add(b.my_global_id, temp_dictionary)
				my_pick.get("dictionary").erase(my_dict_pick)
				b.get_child(0).my_x = iter
				b.get_child(0).my_y = hbox_iter
				b.get_child(0).im_set()
				all_buttons.append(b)
				iter += 1
			hbox_iter += 1


	for i in all_buttons:
		i.get_child(0).get_my_friends(all_buttons)
	print("Yellow: ", yellow_count, " Red: ", red_count, " Blue: ", blue_count)
	#new_clicker.sim_points_per_second()
func recover_perks():
	var hbox_iter = 1
	for row in get_children():
		var iter : int = 1
		for b in row.get_children():
			var current_id : String = str(hbox_iter) + str(iter)
			var my_dictionary : Dictionary = GLOBAL.picked_run_perks.get(current_id)
			var my_perk = my_dictionary.get("perk")
			var my_perk_type = my_dictionary.get("main_type")
			
			b.my_perk_dict = my_perk
			b.my_bought_region = my_perk_type.get("bought_reg")
			b.my_pressed_region = my_perk_type.get("pressed_reg")
			b.my_available_region = my_perk_type.get("available_reg")
			b.my_icon_atlas = my_perk_type.get("atlas")
			b.my_type = my_perk_type.get("type") 
			b.my_global_id = str(hbox_iter) + str(iter)
			b.get_child(0).my_x = iter
			b.get_child(0).my_y = hbox_iter
			b.get_child(0).im_set()
			all_buttons.append(b)
			iter += 1
		hbox_iter += 1

	for i in all_buttons:
		i.get_child(0).get_my_friends(all_buttons)
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("Buy"):
		buy()

func _on_buy_pressed() -> void:
	buy()

func buy()-> void:
	if current_button and current_button.im_ready_to_buy and !new_clicker.time_stopped and !current_button.im_bought and new_clicker.game_started:
		if current_button.my_perk_dict.get("price") <= points_manager.float_points:
			points_manager.float_points -= current_button.my_perk_dict.get("price")
			print("Bought perk value",current_button.my_perk_dict.get("value"))
			current_button.perk_bought.emit()
			show_perks(current_button.get_child(0).friends)
			new_clicker.sim_points_per_second()

func _on_points_manager_hide_unchosen() -> void:
	starters.erase(current_button)
	for i in starters:
		i.hide_perk()

func show_perks(friends : Array) -> void:
	for i in friends:
		if i:
			if i.im_bought or i.im_ready_to_buy:
				pass
			else:
				i.perk_available.emit()
		else:
			pass

func show_ring()-> void:
	ring.visible = true

func move_ring(coords) -> void:
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	tween.tween_property(ring,"position", coords, 0.1)
	tween.play()

func details_updater()-> void:
	if current_button:
		details.visible = true
		details.get_child(2).text = current_button.my_perk_dict.get("name")
		details.get_child(0).texture.set_region(current_button.my_bought_region)
		details.get_child(1).texture.set_atlas(current_button.my_icon_atlas)
		details.get_child(1).texture.set_region(current_button.my_icon_region)
		details.get_child(3).text = current_button.my_perk_dict.get("description")
	else:
		details.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	details_updater()
