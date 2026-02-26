extends Button

@onready var main_menu: Node2D = $"../../.."


var hovered : bool
var selected : bool 
var my_marker : Marker2D


func _ready() -> void:
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	my_marker = get_parent().get_child(0)
	hovered = false
	self.toggle_mode = true
	self.toggled.connect(self._on_button_toggled) 

func _on_mouse_entered() -> void:
	hovered = true
	main_menu.check_current_button(self)
	main_menu.move_indicator(my_marker.global_position)
	expand_text()
	
func _on_mouse_exited() -> void:
	hovered = false
	reduce_text()

func _on_focus_entered() -> void:
	print("focused")
	hovered = true
	main_menu.check_current_button(self)
	main_menu.move_indicator(my_marker.global_position)
	expand_text()
	
func _on_focus_exited() -> void:
	print("unfocused")
	hovered = false
	reduce_text()
	
func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected = true
	else:
		selected = false

func deselect_button() -> void:
	self.button_pressed = false
	
func expand_text()-> void:
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	tween.tween_property(self,"theme_override_font_sizes/font_size", 77, 0.05)
	tween.play()

func reduce_text()-> void:
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	tween.tween_property(self,"theme_override_font_sizes/font_size", 50, 0.05)
	tween.play()

func _process(_delta: float) -> void:
	pass
