extends Button

@onready var label_2: Label = $Label2
@onready var label: Label = $Label

var my_mission : Dictionary = {
	"mission" : null,
	"description" : null, 
	"challenge" : null
}

var my_x : int
var my_y : int

var deleted : bool

var hide_info : bool = true
var completed : bool = false
var locked : bool =  true

func _ready() -> void:
	pass

func debug() -> void:
	print(my_y)
	print(my_x)

func _process(_delta: float) -> void:
	label.text = str(my_x)
	label_2.text = str(my_y)
