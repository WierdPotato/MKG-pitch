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
@onready var price: Label = $Labels/Price

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
	price.text = str(dictionary.get("Price"))
	
	for i in labels.get_children():
		if i.text == "0":
			i.text = "-"
		else:
			pass

func check_selected():
	
	if STORE.selected_part == my_current_part:
		STORE.part_deselected()
	else:
		STORE.part_selected(my_current_part)

func _process(_delta: float) -> void:
	pass
