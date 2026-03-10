extends Node2D


@onready var player: Player = $".."
@onready var shot_machine: Node2D = $"../ShotMachine"

var integrity : float #Almacena la vida del jugadors
var shield : float #Almacena la integridad de los escudos

func _ready() -> void:
	integrity = PREP.ship_hp
	shield = PREP.equiped_parts["sld"].get("HP")
	#print(integrity)
	
func shot_hit(impact : float) -> void:
	var burst : float = 0
	burst = impact - shield
	shield -= impact
	integrity -= burst
	if shield < 0:
		shield = 0

	
func _process(_delta: float) -> void:
	if integrity <= 0:
		PREP.ship_ammo = shot_machine.ammo
		await get_tree().process_frame
		get_parent().queue_free()
		get_tree().change_scene_to_file("res://Prototypes/Menus/Main Menu/Main menu.tscn")
	else:
		pass
