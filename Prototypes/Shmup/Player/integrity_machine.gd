extends Node2D


@onready var player: Player = $".."

var integrity : float #Almacena la vida del jugador
var shield : float #Almacena la integridad de los escudos

func _ready() -> void:
	integrity = PREP.ship_hp
	shield = PREP.equiped_parts["sld"].get("HP")
	print(integrity)
	
func _process(_delta: float) -> void:
	if integrity <= 0:
		await get_tree().process_frame
		get_parent().queue_free()
		get_tree().change_scene_to_file("res://Prototypes/Menus/Main Menu/Main menu.tscn")
	else:
		pass
