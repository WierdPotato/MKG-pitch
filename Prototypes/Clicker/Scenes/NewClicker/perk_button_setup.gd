extends Node

signal all_set

@onready var all_perks: VBoxContainer = $"../../.."
@onready var texture_button : TextureButton = $".."

var rows : int
var columns : int

var im_center : bool

var my_friend_top 
var my_friend_bot
var my_friend_left
var my_friend_right
var my_x : int
var my_y : int
var friends : Array = []

func _ready() -> void:
	rows = all_perks.rows
	columns = all_perks.columns

func set_up()->void:
	pass
	
func im_set() -> void:
	if GLOBAL.current_step == 0:
		if my_x == 1 and my_y == 1:
			apply_starter()
			await get_tree().process_frame
			texture_button.grab_focus()
			all_perks.current_button = texture_button
		elif my_x == all_perks.columns and my_y == all_perks.rows:
			apply_starter()
		elif my_x == all_perks.columns and my_y == 1:
			apply_starter()
		elif my_x == 1 and my_y == all_perks.rows:
			apply_starter()

func apply_starter()->void:
	all_perks.starters.append(texture_button)
	im_center = true
	texture_button.unhide()
	texture_button.perk_available.emit()

func get_my_friends(array):
	for button in array:
		var i : Node = button.get_child(0)
		if i.my_x == my_x:
			if i.my_y == my_y-1:
				my_friend_left = button
				texture_button.focus_neighbor_top= button.get_path()
			if i.my_y == my_y+1:
				my_friend_right = button
				texture_button.focus_neighbor_bottom = button.get_path()
		if i.my_y == my_y:
			if i.my_x == my_x-1:
				my_friend_top = button
				texture_button.focus_neighbor_left = button.get_path()
			if i.my_x == my_x+1:
				my_friend_bot = button
				texture_button.focus_neighbor_right = button.get_path()
				
	friends = [my_friend_bot, my_friend_top, my_friend_left, my_friend_right]
	fill_neighbours(array)
	show_friends()

func fill_neighbours(array)-> void:
	
	if !texture_button.focus_neighbor_top:
		for button in array:
			var i : Node = button.get_child(0)
			if i.my_x == my_x and i.my_y == rows:
				texture_button.focus_neighbor_top = button.get_path()
				
	if !texture_button.focus_neighbor_bottom:
		for button in array:
			var i : Node = button.get_child(0)
			if i.my_x == my_x and i.my_y == 1:
				texture_button.focus_neighbor_bottom = button.get_path()
	
	if !texture_button.focus_neighbor_left:
		for button in array:
			var i : Node = button.get_child(0)
			if i.my_y == my_y and i.my_x == columns:
				texture_button.focus_neighbor_left = button.get_path()
	
	if !texture_button.focus_neighbor_right:
		for button in array:
			var i : Node = button.get_child(0)
			if i.my_y == my_y and i.my_x == 1:
				texture_button.focus_neighbor_right = button.get_path()
				
	all_set.emit()

func show_friends()-> void:
	if texture_button.im_bought:
		all_perks.show_perks(friends)
