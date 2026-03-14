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

@onready var yellow_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/yellow_spritesheet_v1.png")
@onready var red_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/passives_spritesheet_BW_v1.png")
@onready var blue_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/blue_spritesheet_V1.1.png")

@onready var yellow_perk_param : Dictionary = {
	"dictionary" = GLOBAL.yellow_perks_info.duplicate(),
	"bg" = BUBBLE_AMARILLO, 
	"atlas" = yellow_atlas,
	"type" = "yellow"
	
}
@onready var red_perk_param : Dictionary = {
	"dictionary" = GLOBAL.red_perks_info.duplicate(),
	"bg" = BUBBLE_ROJO, 
	"atlas" = red_atlas,
	"type" = "red"
}

@onready var blue_perk_param : Dictionary = {
	"dictionary" = GLOBAL.blue_perks_info.duplicate(),
	"bg" = BUBBLE_AZUL, 
	"atlas" = blue_atlas,
	"type" = "blue"
}




var all_buttons : Array = []
var current_button : TextureButton



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dinamic_size:
		set_up_rows()
	else:
		set_up_buttons()
	
func set_up_rows()-> void:
	for i in rows:
		var current_row_instance = row_template.instantiate()
		add_child(current_row_instance)
		current_row_instance.name = "Fila" + str(i+1)
		for b in columns:
			var current_button_instance = button_template.instantiate()
			current_row_instance.add_child(current_button_instance)
			current_button_instance.name = "Perk" + str(b+1)
	set_up_buttons()
		
func set_up_buttons() -> void:
	var rng = RandomNumberGenerator.new()
	var list : Array = [yellow_perk_param, red_perk_param, blue_perk_param]
	var weights = PackedFloat32Array([yellow_prob, red_prob, blue_prob])
	var hbox_iter = 1
	if real_random:
		for i in get_children():
			for b in i.get_children():
				var my_pick = list[rng.rand_weighted(weights)]
				var my_dict_pick = my_pick.get("dictionary").keys().pick_random()
				b.my_perk_dict = my_dict_pick
				b.my_atlas = my_pick.get("atlas")
				b.my_type = my_pick.get("type") 
				b.texture_normal = my_pick.get("bg")
				my_pick.get("dictionary").erase(my_dict_pick)
	else:
		for row in get_children():
			var prev_pick = null
			var iter : int = 1
			for b in row.get_children():
				var my_pick = list[rng.rand_weighted(weights)]
				if prev_pick:
					if prev_pick == my_pick:
						var aux_list : Array = list.duplicate()
						aux_list.erase(my_pick)
						my_pick = aux_list.pick_random()
						
				var my_dict_pick = my_pick.get("dictionary").keys().pick_random()
				
				b.my_perk_dict = my_pick.get("dictionary").get(my_dict_pick)
				b.texture_normal = my_pick.get("bg")
				b.my_atlas = my_pick.get("atlas")
				b.my_type = my_pick.get("type") 
				my_pick.get("dictionary").erase(my_dict_pick)
				
				b.get_child(0).my_x = iter
				b.get_child(0).my_y = hbox_iter
				b.get_child(0).im_set()
				all_buttons.append(b)
				prev_pick = my_pick
				iter += 1
			hbox_iter += 1
	for i in all_buttons:
		i.get_child(0).get_my_friends(all_buttons)
		
	#new_clicker.sim_points_per_second()
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("Buy"):
		buy()

func _on_buy_pressed() -> void:
	buy()

func buy()-> void:
	if current_button and current_button.im_ready_to_buy and !new_clicker.time_stopped:
		if current_button.my_perk_dict.get("value") <= points_manager.float_points:
			current_button.perk_bought.emit()
			show_perks(current_button.get_child(0).friends)
			new_clicker.sim_points_per_second()
			

func show_perks(friends : Array) -> void:
	for i in friends:
		if i:
			if i.im_bought or i.im_ready_to_buy:
				pass
			else:
				i.perk_available.emit()
		else:
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
