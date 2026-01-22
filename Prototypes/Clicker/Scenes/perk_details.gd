extends Node2D

@onready var perk_icon_bg: Sprite2D = $PerkIconBG
@onready var perk_icon: Sprite2D = $PerkIcon
@onready var perk_name_lbl: Label = $PerkName/PerkNameLBL
@onready var perk_description_lbl: RichTextLabel = $PerkDescription/PerkDescriptionLBL
@onready var details_animation_player: AnimationPlayer = $DetailsAnimationPlayer
@onready var upgrades_manager: Control = $"../UpgradesManager"
@onready var price_lbl: Label = $PriceLBL

@onready var yellow_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/yellow_spritesheet_v1.png")
@onready var red_atlas : CompressedTexture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/passives_spritesheet_BW_v1.png")

var yellow_type : Texture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/bubble_amarillo_prop.png")
var blue_type : Texture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/bubble_azul_prop.png")
var green_type : Texture2D = preload("res://Prototypes/Clicker/Assets/DemoUI/bubble_verde_prop.png")

func change_perk() -> void:
	var perk = upgrades_manager.prev_selected_perk
	details_animation_player.play("perk_changed")
	await get_tree().create_timer(0.1).timeout
	if perk:
		perk_name_lbl.text = perk.my_name
		perk_description_lbl.text = perk.my_current_description
		perk_icon.texture.set_atlas(upgrades_manager.prev_selected_perk.my_atlas)
		perk_icon.texture.set_region(upgrades_manager.prev_selected_perk.my_texture_region)
		price_lbl.text = str(perk.my_price)
		
		if perk.my_dict.get("bought"):
			perk_icon.visible = true
			price_lbl.visible = false
		else:
			perk_icon.visible = false
			price_lbl.visible = true
		
	else:
		clear_info()
	await get_tree().create_timer(0.1).timeout
	
func clear_info() -> void:
	price_lbl.text = ""
	perk_name_lbl.text = ""
	perk_description_lbl.text = ""
	perk_icon.visible = false
	
func change_icon(type_id : int)-> void:
	if type_id == 0:
		perk_icon_bg.texture = yellow_type
		perk_icon.texture.set_atlas(yellow_atlas)
		price_lbl.add_theme_color_override("font_color", Color8(26, 28, 44, 255))
		price_lbl.add_theme_color_override("font_outline_color", Color8(26, 28, 44, 255))

	elif type_id == 1:
		perk_icon_bg.texture = blue_type
		price_lbl.add_theme_color_override("font_color", Color8(244, 244, 244, 255))
		price_lbl.add_theme_color_override("font_outline_color", Color8(244, 244, 244, 255))

	elif type_id == 2:
		perk_icon_bg.texture = green_type
		price_lbl.add_theme_color_override("font_color", Color8(244, 244, 244, 255))
		price_lbl.add_theme_color_override("font_outline_color", Color8(244, 244, 244, 255))

func change_type(type_id : int) -> void:
	details_animation_player.play("type_changed")
	await get_tree().create_timer(0.1).timeout
	clear_info()
	change_icon(type_id)
