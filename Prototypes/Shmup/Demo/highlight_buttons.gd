extends TextureButton


@onready var root_node = get_tree().current_scene
@onready var highlight : Sprite2D 

var hovered : bool
var selected : bool 
func _ready() -> void:
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	hovered = false
	highlight = get_parent().get_child(0)
	self.toggle_mode = true
	self.toggled.connect(self._on_texture_button_toggled) 

func _on_mouse_entered() -> void:
	hovered = true

func _on_mouse_exited() -> void:
	hovered = false


func _on_focus_entered() -> void:
	hovered = true


func _on_focus_exited() -> void:
	hovered = false

func _on_texture_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected = true
		root_node.deselect_prev_button(self)
	else:
		selected = false

func deselect_button() -> void:
	self.button_pressed = false
	

func _process(_delta: float) -> void:
	if hovered or selected:
		highlight.visible = true
	else:
		highlight.visible = false
