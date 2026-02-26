extends Control
@onready var part_1: Node2D = $Part1
@onready var part_2: Node2D = $Part2
@onready var part_3: Node2D = $Part3
@onready var part_4: Node2D = $Part4
@onready var part_5: Node2D = $Part5
@onready var stats_comparator: Node2D = $"../../StatsComparator"

@onready var list_up: TextureButton = $"../Up/ListUP"
@onready var list_down: TextureButton = $"../Down/ListDown"


var selected_parts : Array
var current_pg : int
var current_filter : Array

func _ready() -> void:
	
	on_ready()
	part_1.get_child(1).pressed.connect(self._part_1_pressed) 
	part_2.get_child(1).pressed.connect(self._part_2_pressed) 
	part_3.get_child(1).pressed.connect(self._part_3_pressed) 
	part_4.get_child(1).pressed.connect(self._part_4_pressed) 
	part_5.get_child(1).pressed.connect(self._part_5_pressed) 

func _on_tree_entered() -> void:
	await get_tree().process_frame
	on_ready()

func on_ready() -> void:
	current_pg = 0
	current_filter = PREP.full_inventory.duplicate()
	for i in self.get_child_count():
		self.get_child(i).update_details(current_filter[i])
	print(current_filter.size())

func update_filtered() -> void:
	current_pg = 0
	for i in self.get_child_count():
		if i >= current_filter.size():
			self.get_child(i).visible = false
		else:
			self.get_child(i).update_details(current_filter[i])
			self.get_child(i).visible = true

func move_list()-> void:
	for i in self.get_child_count():
		self.get_child(i).update_details(current_filter[i+current_pg])

func _on_list_up_pressed() -> void:
	if current_pg <= 0:
		pass
	else:
		current_pg -= 1
		move_list()

func _on_list_down_pressed() -> void:
	if self.get_child_count() + current_pg >= current_filter.size():
		pass
	else:
		current_pg += 1
		move_list()

func _part_1_pressed():
	part_1.check_selected()
	stats_comparator.update_texts()
	
func _part_2_pressed():
	part_2.check_selected()
	stats_comparator.update_texts()
	
func _part_3_pressed():
	part_3.check_selected()
	stats_comparator.update_texts()

func _part_4_pressed():
	part_4.check_selected()
	stats_comparator.update_texts()
	
func _part_5_pressed():
	part_5.check_selected()
	stats_comparator.update_texts()
