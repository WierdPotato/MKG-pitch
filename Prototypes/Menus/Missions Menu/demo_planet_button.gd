extends Button

@onready var missions_menu: Node2D = $"../../../.."
@onready var paths_manager: Node2D = $"../../.."

var my_info : Dictionary = {
	"my_name" = null,
	"step" = null,
	"path" = null, 
}

var my_planet : Dictionary = {}

func _ready() -> void:
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	self.pressed.connect(self._im_pressed)
	self.focus_entered.connect(self._im_focused_entered)
	self.focus_exited.connect(self._im_pressed_exited)
	self.mouse_entered.connect(self._im_hovered)
	self.mouse_exited.connect(self._im_unhovered)

func set_info(name : String, step : int, path: int)-> void:
	my_info.set("my_name", name)
	my_info.set("step", step)
	my_info.set("path", path)

func set_planet(planet : Dictionary) -> void:
	my_planet = planet.duplicate()
	PLANETS.assign_refs(my_planet, my_info.get("my_name"))
	get_child(3).texture = my_planet.get("icon")
	
func find_my_planet()-> void:
	print("My info: ",my_info.get("my_name"))
	var planet : Dictionary = PLANETS.referenced_planets.get(my_info.get("my_name"))
	my_planet = planet.duplicate()
	get_child(3).texture = my_planet.get("icon")

func _im_pressed() -> void:
	get_child(1).visible = false
	paths_manager.move_ship(get_child(0).global_position)
	missions_menu.selected_planet = my_planet
	missions_menu.current_planet_ref = my_info.get("my_name")
	missions_menu.bg_planet.texture = my_planet.get("background")
	missions_menu.get_current_planet()
	#missions_menu.update_planet_details()

func _im_focused_entered() -> void:
	get_child(1).visible = true

func _im_pressed_exited() -> void:
	get_child(1).visible = false

func _im_hovered()->void:
	get_child(1).visible = true

func _im_unhovered() -> void:
	get_child(1).visible = false
