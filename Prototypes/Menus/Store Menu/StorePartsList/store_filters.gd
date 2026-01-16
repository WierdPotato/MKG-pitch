extends TabContainer

@onready var all: Control = $All
@onready var bodies: Control = $Bodies
@onready var cargo: Control = $Cargo
@onready var engines: Control = $Engines
@onready var shields: Control = $Shields
@onready var weapons: Control = $Weapons


var filtered_array : Array = []

func _ready() -> void:
	_on_tab_changed(0)
	print("ALL", all)
	all.grab_focus()
func filter_pressed(element, tab):
	tab.get_child(0).add_store_buttons(element)

func deselect_all():
	var tabs : Array = [all, bodies, engines, shields, weapons, cargo]
	for i in tabs:
		for e in i.get_child(0).get_child(0).get_child(0).get_children():
			e.do_deselected()

func _on_tab_changed(tab: int) -> void:
	var tabs : Array = [all, bodies, engines, shields, weapons, cargo]
	print(tabs)
	tabs.erase(tabs[tab])
	for i in tabs:
		print(i)
		for e in i.get_child(0).get_child(0).get_child(0).get_children():
			get_tree().queue_delete(e)
	
	if tab == 0:
		for i in STORE.all_parts:
			filter_pressed(STORE.all_parts.get(i), all)
			
	if tab == 1:
		filter_pressed(STORE.all_bodies_list, bodies)
			
	if tab == 2:
		filter_pressed(STORE.all_cargo_list, cargo)
		
	if tab == 3:
		filter_pressed(STORE.all_engines_list, engines)
	if tab == 4:
		filter_pressed(STORE.all_shields_list, shields)
	if tab == 5:
		filter_pressed(STORE.all_weapons_list, weapons)
