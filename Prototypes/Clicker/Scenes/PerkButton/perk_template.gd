extends Node2D

@warning_ignore("unused_signal")
signal im_selected
@warning_ignore("unused_signal")
signal im_deselected

@onready var name_lbl: Label = $Name
@onready var price_lbl: Label = $PriceLBL

@onready var highlight: Sprite2D = $Highlight
@onready var texture_button: TextureButton = $TextureButton
@onready var icon: Sprite2D = $Icon
@onready var animation_player: AnimationPlayer = $AnimationPlayer



@onready var hover_texture : Texture = preload("res://Prototypes/Clicker/Assets/DemoUI/current_sel_hover.png")
@onready var selected_texture : Texture = preload("res://Prototypes/Clicker/Assets/DemoUI/current_sel.png")

@onready var yellow_perk : Texture = preload("res://Prototypes/Clicker/Assets/DemoUI/bubble_amarillo.png")
@onready var blue_perk : Texture = preload("res://Prototypes/Clicker/Assets/DemoUI/bubble_azul.png")
@onready var green_perk : Texture = preload("res://Prototypes/Clicker/Assets/DemoUI/bubble_verde.png")

@onready var yellow_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/yellow_spritesheet_v1.png")
@onready var red_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/passives_spritesheet_BW_v1.png")
@onready var blue_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/blue_spritesheet_V1.1.png")

@onready var locked: Sprite2D = $Locked



var my_key : int
var my_dict : Dictionary
var my_name : String
var my_info : String 
var my_price : int
var my_current_description : String
var my_description : String
var my_type : int
var my_texture_region : Rect2
var my_atlas : Texture2D
var my_position : int
var my_bg : Texture

var unlocked : bool = false

var im_connected : bool
var selected : bool
var hovered : bool

func _ready() -> void:
	im_connected = false

func update_global_name(input : String) -> void:
	name_lbl.text = input

func update_info(grid_position : int, type_id : int) -> void: #Cambiar atlas y diccionario cuando los tenga
	my_key = grid_position
	var key_number : String = str(grid_position)
	if type_id == 0:
		my_atlas = yellow_atlas
		my_dict = GLOBAL.yellow_perks_info.get(key_number)
		set_info(my_dict)
		my_type = type_id
		my_bg = yellow_perk
		price_lbl.add_theme_color_override("font_color", Color8(26, 28, 44, 255))
		price_lbl.add_theme_color_override("font_outline_color", Color8(26, 28, 44, 255))
		
	elif type_id == 1:
		my_atlas = blue_atlas
		my_dict = GLOBAL.blue_perks_info.get(key_number)
		set_info(my_dict)
		my_type = type_id
		my_bg = blue_perk
		price_lbl.add_theme_color_override("font_color", Color8(244, 244, 244, 255))
		price_lbl.add_theme_color_override("font_outline_color", Color8(244, 244, 244, 255))
		
	elif type_id == 2:
		my_atlas = red_atlas
		my_dict = GLOBAL.red_perks_info.get(key_number)
		set_info(my_dict)
		my_type = type_id
		my_bg = green_perk
		price_lbl.add_theme_color_override("font_color", Color8(244, 244, 244, 255))
		price_lbl.add_theme_color_override("font_outline_color", Color8(244, 244, 244, 255))
	
	if my_key == 1:
		texture_button.grab_focus()
		print("sup")
	else:
		pass
	
func set_info(dict : Dictionary) -> void:
	dict.set("my_button", self)
	my_price = dict.get("price")
	my_name = dict.get("name")
	var region = dict.get("region")
	my_texture_region = Rect2(region.get("x"), region.get("y"), region.get("w"), region.get("h"))
	my_price = dict.get("price")
	my_description = dict.get("description")
	manage_unlocked()
	
	
func change_textures(animated)-> void:
	if animated:
		animation_player.play("down_flip")
		await get_tree().create_timer(0.1).timeout
		manage_available()
		texture_button.texture_normal = my_bg
		name_lbl.text = my_name
		price_lbl.text = str(my_price)
		icon.texture.set_atlas(my_atlas)
		icon.texture.set_region(my_texture_region)
	else:
		manage_available()
		texture_button.texture_normal = my_bg
		name_lbl.text = my_name
		price_lbl.text = str(my_price)
		icon.texture.set_atlas(my_atlas)
		icon.texture.set_region(my_texture_region)

func _on_texture_button_mouse_entered() -> void:
	hovered = true

func _on_texture_button_mouse_exited() -> void:
	hovered = false

func _on_texture_button_focus_entered() -> void:
	hovered = true

func _on_texture_button_focus_exited() -> void:
	hovered = false

func _on_texture_button_toggled(toggled_on: bool) -> void:
	print(my_name,": " ,toggled_on)
	if toggled_on:
		highlight.texture = selected_texture
		selected = true
		im_selected.emit(self)

	else:
		highlight.texture = hover_texture
		selected = false
		im_deselected.emit(self)

func deselect_button() -> void:
	texture_button.button_pressed = false

func buy_perk() -> void:
	my_dict.set("bought", true)

func manage_unlocked() -> void: #Gestiona si la mejora está comprada o no
	if my_dict.get("bought") == false:
		icon.visible = false
		price_lbl.visible = true
		my_current_description = "Who knows..."
	
	else:
		icon.visible = true
		price_lbl.visible = false
		my_current_description = my_description

func manage_available() -> void: #Gestiona si la mejora está disponible para compra
	if my_dict.get("available"):
		texture_button.disabled = false
		locked.visible = false
	else:
		texture_button.disabled = true
		locked.visible = true

func animate_lock() -> void:
	print("YOOOW", my_name)
	animation_player.play("lock_off")
	await animation_player.animation_finished
	locked.visible = false
	texture_button.disabled = false
	locked.set_scale(Vector2(0.9, 0.9))

func check_price()-> void:
	if my_price <= GLOBAL.money and my_dict.get("available") or my_dict.get("bought"):
		texture_button.self_modulate = Color8(255, 255, 255, 255)
	else:
		texture_button.self_modulate = Color8(179, 179, 179, 255)

func _process(_delta: float) -> void:
	if my_price <= GLOBAL.money and my_dict.get("available") or my_dict.get("bought"):
		texture_button.self_modulate = Color8(255, 255, 255, 255)
	else:
		texture_button.self_modulate = Color8(179, 179, 179, 255)
		
	if hovered == true or selected == true:
		highlight.visible = true
	else:
		highlight.visible = false
