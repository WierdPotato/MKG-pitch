extends Control


@onready var name_tag: Label = $Name
@onready var type: Label = $Type
@onready var blueprint: Sprite2D = $Blueprint


@onready var hp: Label = $VBoxContainer/FirstRowValue/HP
@onready var area: Label = $VBoxContainer/FirstRowValue/AREA
@onready var weight: Label = $VBoxContainer/FirstRowValue/Weight
@onready var speed: Label = $VBoxContainer/FirstRowValue/Speed
@onready var force: Label = $VBoxContainer/FirstRowValue/Force
@onready var capacity: Label = $VBoxContainer/SecondRowValues/Capacity
@onready var damage: Label = $VBoxContainer/SecondRowValues/Damage
@onready var cadence: Label = $VBoxContainer/SecondRowValues/Cadence
@onready var rounds: Label = $VBoxContainer/SecondRowValues/Rounds
@onready var size_value: Label = $VBoxContainer/SecondRowValues/Size


func preview_manager() -> void:
	if STORE.previewing == true:
		if self.visible == false:
			self.visible = true
		else:
			pass
	else:
		if self.visible == true:
			self.visible = false
		else:
			pass

func update_preview() -> void:
	blueprint.texture = STORE.preview_blueprint
	name_tag.text = STORE.preview_name
	type.text = STORE.preview_type
	hp.text = STORE.preview_hp
	weight.text = STORE.preview_weight
	speed.text = STORE.preview_speed
	force.text = STORE.preview_force
	capacity.text = STORE.preview_capacity
	damage.text = STORE.preview_damage
	cadence.text = STORE.preview_cadence
	rounds.text = STORE.preview_rounds
	size_value.text = STORE.preview_size
	
func _process(_delta: float) -> void:
	preview_manager()
	update_preview()
