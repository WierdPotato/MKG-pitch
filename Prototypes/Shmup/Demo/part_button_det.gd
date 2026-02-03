extends Node2D

@onready var labels: Node2D = $Labels
@onready var part_name: Label = $Labels/PartName
@onready var hp: Label = $Labels/HP
@onready var size: Label = $Labels/Size
@onready var weight: Label = $Labels/Weight
@onready var speed: Label = $Labels/Speed
@onready var thrust: Label = $Labels/Thrust
@onready var capacity: Label = $Labels/Capacity
@onready var damage: Label = $Labels/Damage
@onready var cadence: Label = $Labels/Cadence
@onready var ammo: Label = $Labels/Ammo

var my_current_part :Dictionary

var selected : bool

func hide_myself():
	self.visible = false

func update_details(dictionary : Dictionary) -> void:
	my_current_part = dictionary
	
	part_name.text = dictionary.get("Name")
	hp.text = str(dictionary.get("HP"))
	size.text = str(dictionary.get("Size"))
	weight.text = str(dictionary.get("Weight"))
	speed.text = str(dictionary.get("Speed"))
	thrust.text = str(dictionary.get("Force"))
	capacity.text = str(dictionary.get("Capacity"))
	damage.text = str(dictionary.get("Damage"))
	cadence.text = str(dictionary.get("Cadence"))
	ammo.text = str(dictionary.get("Rounds"))
	
	for i in labels.get_children():
		if i.text == "0":
			i.text = "-"
		else:
			pass

func check_selected():
	if PREP.sim_parts.get(my_current_part.get("Type")) == my_current_part:
		PREP.sim_parts.set(my_current_part.get("Type"), PREP.equiped_parts.get(my_current_part.get("Type")))
		PREP.simulate_stats()
	else:
		PREP.sim_parts.set(my_current_part.get("Type"), my_current_part)
		PREP.simulate_stats()

func _process(_delta: float) -> void:
	if PREP.sim_parts.get(my_current_part.get("Type")) == my_current_part:
		if PREP.equiped_parts.get(my_current_part.get("Type")) != my_current_part:
			selected = true
			get_child(2).visible = true
		else:
			selected = false
			get_child(2).visible = false
	else:
		selected = false
		get_child(2).visible = false
