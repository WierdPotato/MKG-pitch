extends Control

func _ready() -> void:
	for i in get_child(0).get_children():
		for x in i.get_children():
			var perk = x.get_child(0)
			perk.update_global_name(str(perk))
