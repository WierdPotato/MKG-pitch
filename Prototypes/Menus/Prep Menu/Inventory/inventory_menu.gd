extends TabContainer

@onready var all: Control = $All
@onready var bodies: Control = $Bodies
@onready var engines: Control = $Engines
@onready var shields: Control = $Shields
@onready var weapons: Control = $Weapons
@onready var cargo: Control = $Cargo

var full_inventory : Array = PREP.full_inventory

var filtered_array : Array = []

func _ready() -> void:
	all_pressed()

func all_pressed() -> void:
	if all.get_child(0).get_child(0).get_child(0).get_child_count() == 0:
		#print(all.get_child(0))
		all.get_child(0).add_buttons(full_inventory)
	else:
		pass

func filter_pressed(tab_name : String, tab : Control):
	filtered_array.clear()
	
	for i in full_inventory:
		if i.Type == tab_name:
			filtered_array.append(i)
		else:
			pass
	tab.get_child(0).add_buttons(filtered_array)

func _on_tab_changed(tab: int) -> void:
	var tabs : Array = [all, bodies, engines, shields, weapons, cargo]
	tabs.erase(tabs[tab])
	print("Tabs:", tabs)
	for i in tabs:
		for e in i.get_child(0).get_child(0).get_child(0).get_children():
			get_tree().queue_delete(e)
	
	if tab == 0:
		all_pressed()
	if tab == 1:
		filter_pressed("bdy", bodies)
	if tab == 2:
		filter_pressed("crg", cargo)
	if tab == 3:
		filter_pressed("eng", engines)
	if tab == 4:
		filter_pressed("sld", shields)
	if tab == 5:
		filter_pressed("wpn", weapons)
