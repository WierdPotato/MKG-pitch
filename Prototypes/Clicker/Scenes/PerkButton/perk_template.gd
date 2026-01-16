extends Node2D

var my_name : String
var my_icon : Texture2D
var my_info : String 
var my_price : int
var my_value : int
var my_type : int

@onready var name_lbl: Label = $Name

func _ready() -> void:
	pass

func update_global_name(input : String) -> void:
	name_lbl.text = input
