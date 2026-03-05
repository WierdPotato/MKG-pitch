extends Button

@onready var missions_menu: Node2D = $"../../../.."
@onready var paths_manager: Node2D = $"../../.."

var my_info : Dictionary = {
	"my_ref" = null,
	"my_name" = null,
	"step" = null,
	"path" = null, 
	"completed" = null,
	"locked" = null
}

var my_mission : Dictionary = {
	"name" = null,
	"description" = null,
	"main_objective" = null, 
	"goal" = null,
	"subject" = null,
	"challenge" = null
}

var my_planet : Dictionary = {
	"id" = null, 
	"name" = null,
	"density" = null,
	"temp" = null,
	"icon" = null, 
	"background" = null, 
	"parallaxID" = null
}

func _ready() -> void:
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	self.pressed.connect(self._im_pressed)
	self.focus_entered.connect(self._im_focused_entered)
	self.focus_exited.connect(self._im_pressed_exited)
	self.mouse_entered.connect(self._im_hovered)
	self.mouse_exited.connect(self._im_unhovered)

func set_info(step : int, name : String)-> void:
	my_info.set("my_ref", self)
	my_info.set("my_name", name)
	if get_parent().get_parent().name == "PathA":
		my_info.set("path", 1)
	elif get_parent().get_parent().name == "PathB":
		my_info.set("path", 2)
	else:
		my_info.set("path", 0)
	
	my_info.set("step", step)

func set_planet(planet : Dictionary) -> void:
	my_planet.set("id", planet.get("id"))
	my_planet.set("name", planet.get("name"))
	my_planet.set("density", planet.get("density"))
	my_planet.set("temp", planet.get("temp"))
	my_planet.set("icon", planet.get("icon"))
	my_planet.set("background", planet.get("background"))
	my_planet.set("parallaxID", planet.get("parallaxID"))
	PLANETS.assign_refs(my_planet, my_info.get("my_name"))
	get_child(3).texture = my_planet.get("icon")
	
func find_my_planet()-> void:
	print("My info: ",my_info.get("my_name"))
	var planet : Dictionary = PLANETS.processed_planets.get(my_info.get("my_name"))
	my_planet.set("id", planet.get("id"))
	my_planet.set("name", planet.get("name"))
	my_planet.set("density", planet.get("density"))
	my_planet.set("temp", planet.get("temp"))
	my_planet.set("icon", planet.get("icon"))
	my_planet.set("background", planet.get("background"))
	my_planet.set("parallaxID", planet.get("parallaxID"))
	get_child(3).texture = my_planet.get("icon")

func set_mission(mission : Dictionary) -> void:
	my_mission.set("name", mission.get("names").pick_random())
	my_mission.set("challenge",mission.get("challenges").pick_random().get("objective"))
	my_mission.set("main_objective", mission.get("objective"))
	my_mission.set("goal", mission.get("goal"))
	my_mission.set("subject", mission.get("subject"))
	my_mission.set("description", mission.get("descriptions").get(str(randi_range(1, 3))))
	MISSIONS.assign_refs(my_mission, my_info.get("my_name"))

func find_my_mission()->void:
	var mission = MISSIONS.processed_missions.get(str(self))
	my_mission.set("name", mission.get("name"))
	my_mission.set("challenge",mission.get("challenge"))
	my_mission.set("main_objective", mission.get("main_objective"))
	my_mission.set("goal", mission.get("goal"))
	my_mission.set("subject", mission.get("subject"))
	my_mission.set("description", mission.get("description"))

func _im_pressed() -> void:
	get_child(1).visible = false
	paths_manager.move_ship(get_child(0).global_position)
	missions_menu.selected_mission = my_mission
	missions_menu.selected_planet = my_planet
	missions_menu.current_planet = self
	missions_menu.bg_planet.texture = my_planet.get("background")
	
	if missions_menu.missions_mode:
		missions_menu.update_mission_details()
	else:
		missions_menu.update_planet_details()

func _im_focused_entered() -> void:
	get_child(1).visible = true

func _im_pressed_exited() -> void:
	get_child(1).visible = false

func _im_hovered()->void:
	get_child(1).visible = true

func _im_unhovered() -> void:
	get_child(1).visible = false
