extends Node2D

@onready var lvl_3: Button = $Lvl3

@onready var path_a: Node2D = $PathA
@onready var path_b: Node2D = $PathB

var buttons_group_a : Control
var lines_group_a : Node2D
var buttons_a : Array
var lines_a : Array

var buttons_group_b : Control
var lines_group_b : Node2D
var buttons_b : Array
var lines_b : Array

func _ready() -> void:
	buttons_group_a = path_a.get_child(0)
	lines_group_a = path_a.get_child(1)
	buttons_a = buttons_group_a.get_children()
	lines_a = lines_group_a.get_children()
	
	buttons_group_b = path_b.get_child(0)
	lines_group_b = path_b.get_child(1)
	buttons_b = buttons_group_b.get_children()
	lines_b = lines_group_b.get_children()
	
	for i in buttons_a:
		hide_manager(i, true)
	
	for i in buttons_b:
		hide_manager(i, true)

	hide_manager(buttons_a[GLOBAL.current_step], false)
	hide_manager(buttons_b[GLOBAL.current_step], false)

func hide_manager(button : Button, opt : bool) -> void:
	if opt:
		button.locked = true
	else:
		button.locked = false
