extends Node2D

@onready var missions_menu: Node2D = $".."

@onready var lvl_1a: Button = $PathA/Buttons/Lvl1a
@onready var lvl_1b: Button = $PathB/Buttons/Lvl1b
@onready var lvl_2a: Button = $PathA/Buttons/Lvl2a
@onready var lvl_2b: Button = $PathB/Buttons/Lvl2b
@onready var lvl_3: Button = $Final/Boss/Lvl3


@onready var ship: Sprite2D = $Overlay/Ship



func _ready() -> void:
	if GLOBAL.current_step == 0:
		print("current step: ", GLOBAL.current_step)
		lvl_1a.grab_focus()
		move_ship(lvl_1a.get_child(0).global_position)
		
	else:
		print("current step: ", GLOBAL.current_step)
		missions_menu.current_planet.grab_focus()
		move_ship(missions_menu.current_planet.get_child(0).global_position)
	
func lock_missions(missions: Array)-> void:
	for i in missions:
		i.disabled = true
		i.get_child(2).visible = true
		
func unlock_missions(missions : Array)-> void:
	for i in missions:
		i.disabled = false
		i.get_child(2).visible = false



func move_ship(target) -> void:
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	tween.tween_property(ship,"position", target, 0.15)
	tween.play()
