extends Button

var my_mission : Dictionary = {
	"mission" : null,
	"description" : null, 
	"challenge" : null
}

var hide_info : bool = true
var completed : bool = false
var locked : bool =  true

func _ready() -> void:
	if completed:
		self.disabled = true
	else:
		self.disabled = false
		
	await get_tree().process_frame
