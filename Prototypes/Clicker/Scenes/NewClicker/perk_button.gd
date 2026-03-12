extends TextureButton

@onready var all_perks: VBoxContainer = $"../.."


var im_center : bool
var im_unlocked : bool
var my_friend_top 
var my_friend_bot
var my_friend_left
var my_friend_right
const PAUSE_BTN = preload("uid://dhmckdb42fsea")

var my_x : int
var my_y : int
var friends : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(self._im_pressed)
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	texture_focused = PAUSE_BTN
	disabled = true

func im_set() -> void:
	if my_x == 4 and my_y == 4:
		im_center = true
		im_unlocked = true
		disabled = false
		grab_focus()

func get_my_friends(array):
	for i in array:
		if i.my_x == my_x:
			if i.my_y == my_y-1:
				my_friend_left = i
				focus_neighbor_top= i.get_path()
			if i.my_y == my_y+1:
				my_friend_right = i
				focus_neighbor_bottom = i.get_path()
		if i.my_y == my_y:
			if i.my_x == my_x-1:
				my_friend_top = i
				focus_neighbor_left = i.get_path()
			if i.my_x == my_x+1:
				my_friend_bot = i
				focus_neighbor_right = i.get_path()
				
	friends = [my_friend_bot, my_friend_top, my_friend_left, my_friend_right]
	fill_neighbours(array)
	show_friends()
	
func show_friends()-> void:
	if im_unlocked:
		all_perks.show_perks(friends)

func fill_neighbours(array)-> void:
	
	if !focus_neighbor_top:
		for i in array:
			if i.my_x == my_x and i.my_y == 7:
				focus_neighbor_top = i.get_path()
				
	if !focus_neighbor_bottom:
		for i in array:
			if i.my_x == my_x and i.my_y == 1:
				focus_neighbor_bottom = i.get_path()
	
	if !focus_neighbor_left:
		for i in array:
			if i.my_y == my_y and i.my_x == 7:
				focus_neighbor_left = i.get_path()
	
	if !focus_neighbor_right:
		for i in array:
			if i.my_y == my_y and i.my_x == 1:
				focus_neighbor_right = i.get_path()

func _im_pressed()->void:
	print("im pressed", self)
	all_perks.current_button = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
