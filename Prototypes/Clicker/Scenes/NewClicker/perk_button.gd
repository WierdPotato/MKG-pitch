extends TextureButton

signal perk_bought
signal perk_available

@onready var all_perks: VBoxContainer = $"../.."

@onready var normal_bought_texture 
@onready var normal_available_texture

@onready var price_tag: Label = $PriceTag
@onready var ready_price_color : Color = Color(0.957, 0.957, 0.957)
@onready var red_price_color : Color = Color(1.0, 0.141, 0.122)

@onready var icon: Sprite2D = $Icon

var points_input : float

var my_texture_region : Rect2
const PAUSE_BTN = preload("uid://dhmckdb42fsea")

var im_set : bool
var my_perk_dict : Dictionary 
var my_atlas : CompressedTexture2D
var my_type : String

var im_bought : bool
var im_ready_to_buy : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disabled = true
	im_set = false
	im_bought = false
	im_ready_to_buy = false
	self.pressed.connect(self._im_pressed)
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	texture_focused = PAUSE_BTN
	disabled = true

func _im_pressed()->void:
	all_perks.current_button = self

func _on_set_up_all_set() -> void:
	var region = my_perk_dict.get("region")
	my_texture_region = Rect2(region.get("x"), region.get("y"), region.get("w"), region.get("h"))
	im_set = true
	icon.texture.set_atlas(my_atlas)
	icon.texture.set_region(my_texture_region)

	if im_bought:
		icon.visible = true
	
func _on_perk_bought() -> void:
	im_bought = true
	icon.visible = true
	price_tag.visible = false
	if my_type == "yellow":
		GLOBAL.total_yellow += my_perk_dict.get("value")
	elif my_type == "red":
		GLOBAL.total_red += my_perk_dict.get("value")
	else:
		pass

func _on_perk_available() -> void:
	adapt_price()
	disabled = false
	price_tag.text = str(my_perk_dict.get("price"))
	price_tag.visible = true
	im_ready_to_buy = true

func adapt_price() -> void:
	if points_input < 10:
		if my_perk_dict.get("price") <= 100:
			pass
		elif my_perk_dict.get("price") > 100 and my_perk_dict.get("price") <= 400:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", int(round(og_price/1.5)))
			
		elif my_perk_dict.get("price") > 400 and my_perk_dict.get("price") <= 600:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", round(og_price/2))
		
		elif my_perk_dict.get("price") > 600 and my_perk_dict.get("price") <= 1000:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", round(og_price/2.5))
			
		elif my_perk_dict.get("price") > 1000 and my_perk_dict.get("price") <= 5000:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", round(og_price/4))

		elif my_perk_dict.get("price") > 5000 and my_perk_dict.get("price") <= 10000:
			var og_price = my_perk_dict.get("price")
			my_perk_dict.set("price", round(og_price/7))
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	points_input = GLOBAL.simulated_points
