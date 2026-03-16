extends TextureButton

signal perk_bought
signal perk_available

@onready var all_perks: VBoxContainer = $"../.."

@onready var normal_bought_texture 
@onready var normal_available_texture

@onready var price_tag: Label = $PriceTag
@onready var ready_price_color : Color = Color(0.957, 0.957, 0.957)
@onready var ready_price_black : Color = Color(0.102, 0.11, 0.173, 1.0)
@onready var red_price_color : Color = Color(0.691, 0.247, 0.327, 1.0)

@onready var icon: Sprite2D = $Icon
@onready var marker_2d: Marker2D = $Marker2D

var points_input : float

var my_icon_region : Rect2
var my_icon_atlas : CompressedTexture2D

const atlas = preload("uid://b34cj02qi4rjv")
@onready var normal_region = Rect2(816, 0, 400, 400)
@onready var pressed_region = Rect2(0, 816, 400, 400)

var my_bought_region : Rect2
var my_pressed_region : Rect2
var my_available_region : Rect2

var im_set : bool
var my_perk_dict : Dictionary 
var my_global_id : String
var my_type : String

var im_bought : bool
var im_ready_to_buy : bool



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disabled = true
	self_modulate.a = 0
	focus_mode = Control.FOCUS_NONE
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	im_set = false
	im_bought = false
	im_ready_to_buy = false
	self.pressed.connect(self._im_pressed)
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _on_set_up_all_set() -> void:
	var region = my_perk_dict.get("region")
	my_icon_region = Rect2(region.get("x"), region.get("y"), region.get("w"), region.get("h"))
	icon.texture.set_atlas(my_icon_atlas)
	icon.texture.set_region(my_icon_region)
	texture_normal.atlas = atlas
	texture_normal.region = normal_region #Cambiar aquí si está pequeño o grande
	im_set = true
	
	if my_perk_dict.get("bought") == true:
		#print("Check bought: ", my_perk_dict)
		_on_perk_bought()
		unhide()
	if im_bought:
		icon.visible = true
	
	if GLOBAL.last_focused_perk == my_global_id:
		grab_focus()

func _on_perk_bought() -> void:
	im_bought = true
	my_perk_dict.set("bought", true)
	icon.visible = true
	price_tag.visible = false
	self.texture_normal.atlas = atlas
	self.texture_normal.region = my_bought_region
	self.texture_pressed.region = my_pressed_region
	if my_type == "yellow":
		GLOBAL.total_yellow += my_perk_dict.get("value")
	elif my_type == "red":
		GLOBAL.total_red += my_perk_dict.get("value")
	else:
		manage_blue_perks()

func manage_blue_perks()-> void:
	var my_subtype = my_perk_dict.get("subtype")
	if my_subtype == "1a":
		GLOBAL.total_pcn_yellow += my_perk_dict.get("value")
		
	elif my_subtype == "1b":
		GLOBAL.total_gen_pcn_yellow += my_perk_dict.get("value")
			
	elif my_subtype == "2a":
		GLOBAL.total_pcn_red += my_perk_dict.get("value")
			
	elif my_subtype == "2b":
		GLOBAL.total_red_cd_reduction += my_perk_dict.get("value")
			
	elif my_subtype == "3a":
		pass #mejora estadisticas de las piezas de las naves
		
	elif my_subtype == "4a":
		pass #desbloquea una pieza para la nave

func _on_perk_available() -> void:
	adapt_price()
	disabled = false
	price_tag.text = str(my_perk_dict.get("price"))
	price_tag.visible = true
	im_ready_to_buy = true
	unhide()

func hide_perk() -> void:
	disabled = true
	price_tag.visible = false
	im_ready_to_buy = false
	icon.visible = false
	get_child(0).im_center = false
	self_modulate.a = 0
	focus_mode = Control.FOCUS_NONE
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	pass

func unhide() -> void:
	disabled = false
	self_modulate.a = 255
	focus_mode = Control.FOCUS_ALL
	mouse_filter = Control.MOUSE_FILTER_STOP

func adapt_price() -> void:
	if points_input < 10:
		if my_perk_dict.get("price") <= 100:
			pass
		elif my_perk_dict.get("price") > 100 and my_perk_dict.get("price") <= 400:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", int(round(og_price/1.5)))
			
		elif my_perk_dict.get("price") > 400 and my_perk_dict.get("price") <= 600:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", round(og_price/3))

		elif my_perk_dict.get("price") > 600 and my_perk_dict.get("price") <= 1000:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", round(og_price/4.5))

		elif my_perk_dict.get("price") > 1000 and my_perk_dict.get("price") <= 5000:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", round(og_price/6))

		elif my_perk_dict.get("price") > 5000 and my_perk_dict.get("price") <= 10000:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", round(og_price/7.5))


func _im_pressed()->void:
	all_perks.current_button = self

func _on_focus_entered() -> void:
	all_perks.show_ring()
	all_perks.move_ring(marker_2d.global_position)

func _on_mouse_entered() -> void:
	all_perks.show_ring()
	all_perks.move_ring(marker_2d.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	points_input = GLOBAL.simulated_points
	if all_perks.current_button == self:
		if im_bought:
			self.texture_normal.region = my_pressed_region
		else:
			self.texture_normal.region = pressed_region
	else:
		if im_bought:
			self.texture_normal.region = my_bought_region
		else:
			self.texture_normal.region = my_available_region
		
	if GLOBAL.money >= my_perk_dict.get("price"):
		price_tag.add_theme_color_override("font_color", ready_price_color)
		price_tag.add_theme_color_override("font_outline_color", ready_price_color)
	else:
		price_tag.add_theme_color_override("font_color", red_price_color)
		price_tag.add_theme_color_override("font_outline_color", red_price_color)
