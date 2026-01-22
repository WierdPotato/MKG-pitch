extends Node2D

@onready var progress_bar: ProgressBar = $LoadManager/ProgressBar
@onready var ship_sprite: AnimatedSprite2D = $ShipSprite

@onready var engine_name: Label = $PartsManager/Engine
@onready var body_name: Label = $PartsManager/Body
@onready var weapon_name: Label = $PartsManager/Weapon
@onready var cargo_name: Label = $PartsManager/Cargo
@onready var shield_name: Label = $PartsManager/Shield

@onready var health_value: Label = $StatsManager/Values/Health
@onready var area_value: Label = $StatsManager/Values/Area
@onready var mass_value: Label = $StatsManager/Values/Mass
@onready var speed_value: Label = $StatsManager/Values/Speed
@onready var force_value: Label = $StatsManager/Values/Force
@onready var capacity_value: Label = $StatsManager/Values/Capacity
@onready var damage_value: Label = $StatsManager/Values/Damage
@onready var cadence_value: Label = $StatsManager/Values/Cadence
@onready var ammo_value: Label = $StatsManager/Values/Ammo

@onready var sim_health: Label = $StatsManager/SimValues/Health
@onready var sim_area: Label = $StatsManager/SimValues/Area
@onready var sim_mass: Label = $StatsManager/SimValues/Mass
@onready var sim_speed: Label = $StatsManager/SimValues/Speed
@onready var sim_force: Label = $StatsManager/SimValues/Force
@onready var sim_capacity: Label = $StatsManager/SimValues/Capacity
@onready var sim_damage: Label = $StatsManager/SimValues/Damage
@onready var sim_cadence: Label = $StatsManager/SimValues/Cadence
@onready var sim_ammo: Label = $StatsManager/SimValues/Ammo

func _ready() -> void:
	preview_stats()
	ship_sprite.play("default")
func update_load() -> void:
	var value = PREP.selected_parts_dict.bdy.Capacity
	progress_bar.max_value = value
	progress_bar.value = add_load()

func add_load() -> float: 
	var total_value : float = 0
	for i in PREP.selected_parts_list:
		total_value += i.Size
	return total_value

func update_stats() -> void:
	health_value.text = str(add_stats("HP", PREP.selected_parts_list))
	area_value.text = str(add_stats("Area", PREP.selected_parts_list))
	mass_value.text = str(add_stats("Weight", PREP.selected_parts_list))
	speed_value.text = str(add_stats("Speed", PREP.selected_parts_list))
	force_value.text = str(add_stats("Force", PREP.selected_parts_list))
	capacity_value.text = str(add_stats("Capacity", PREP.selected_parts_list))
	damage_value.text = str(add_stats("Damage", PREP.selected_parts_list))
	cadence_value.text = str(add_stats("Cadence", PREP.selected_parts_list))
	ammo_value.text = str(add_stats("Rounds", PREP.selected_parts_list))

func preview_stats() -> void:
	
	sim_health.text = edit_text(add_stats("HP", PREP.preselected_parts_list))
	sim_area.text = edit_text(add_stats("Area", PREP.preselected_parts_list))
	sim_mass.text = edit_text(add_stats("Weight", PREP.preselected_parts_list))
	sim_speed.text = edit_text(add_stats("Speed", PREP.preselected_parts_list))
	sim_force.text = edit_text(add_stats("Force", PREP.preselected_parts_list))
	sim_capacity.text = edit_text(add_stats("Capacity", PREP.preselected_parts_list))
	sim_damage.text = edit_text(add_stats("Damage", PREP.preselected_parts_list))
	sim_cadence.text = edit_text(add_stats("Cadence", PREP.preselected_parts_list))
	sim_ammo.text = edit_text(add_stats("Rounds", PREP.preselected_parts_list))

func update_parts() -> void: 
	engine_name.text = PREP.selected_parts_dict.eng.Name
	body_name.text = PREP.selected_parts_dict.bdy.Name
	weapon_name.text = PREP.selected_parts_dict.wpn.Name
	cargo_name.text = PREP.selected_parts_dict.crg.Name
	shield_name.text = PREP.selected_parts_dict.sld.Name

func add_stats(parameter, list) -> float:
	var value : float = 0
	if parameter == "Weight":
		value += PREP.ship_ammo * 0.01
		
	for i in list:
		value += i.get(parameter)
	return value

func edit_text(value) -> String:
	var final_value
	if value == 0:
		final_value = "-"
	else:
		final_value = str(value)
	return final_value

func _process(_delta: float) -> void:
	update_load()
	update_parts()
	update_stats()
	preview_stats()
