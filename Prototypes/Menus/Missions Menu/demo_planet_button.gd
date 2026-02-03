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


func _ready() -> void:
	
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	self.pressed.connect(self._im_pressed)
	self.focus_entered.connect(self._im_focused_entered)
	self.focus_exited.connect(self._im_pressed_exited)
	self.mouse_entered.connect(self._im_hovered)
	self.mouse_exited.connect(self._im_unhovered)

func set_info(step : int)-> void:
	my_info.set("my_ref", self)
	if get_parent().get_parent().name == "PathA":
		my_info.set("path", 1)
	elif get_parent().get_parent().name == "PathB":
		my_info.set("path", 2)
	else:
		my_info.set("path", 0)
	
	my_info.set("step", step)
	
func set_mission(mission : Dictionary) -> void:
	my_mission.set("name", mission.get("names").pick_random())
	my_mission.set("challenge",mission.get("challenges").pick_random().get("objective"))
	my_mission.set("main_objective", mission.get("objective"))
	my_mission.set("goal", mission.get("goal"))
	my_mission.set("subject", mission.get("subject"))
	my_mission.set("description", mission.get("descriptions").get(str(randi_range(1, 3))))
	MISSIONS.assign_refs(my_mission, self)

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
	missions_menu.current_planet = self
	missions_menu.update_mission_details()
	
func _im_focused_entered() -> void:
	get_child(1).visible = true

func _im_pressed_exited() -> void:
	get_child(1).visible = false

func _im_hovered()->void:
	get_child(1).visible = true

func _im_unhovered() -> void:
	get_child(1).visible = false
