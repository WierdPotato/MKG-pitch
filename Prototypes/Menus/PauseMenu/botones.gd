extends Node2D

@onready var grafismos: Node2D = $"../Grafismos"

@onready var music_button: Button = $Music/MusicButton
@onready var music_h_slider: HSlider = $Music/MusicHSlider
@onready var sfx_h_slider: HSlider = $SFX/SfxHSlider
@onready var lang_button: Button = $Language/LangButton
@onready var main_button: Button = $Main/MainButton
@onready var exit_button: Button = $Exit/ExitButton
@onready var controls_button: TextureButton = $Controls/ControlsButton


@onready var indicator: Sprite2D = $Indicator

@onready var music: Node2D = $Music
@onready var sfx: Node2D = $SFX
@onready var language: Node2D = $Language
@onready var main: Node2D = $Main
@onready var exit: Node2D = $Exit
@onready var return_button: Node2D = $Return
@onready var controls: Node2D = $Controls


func get_focus()-> void:
	music_button.grab_focus()
	
#########################################################

func _on_music_button_mouse_entered() -> void:
	grafismos.change_grafismo(1)
	move_indicator(music.get_child(3).global_position)

func _on_music_button_mouse_exited() -> void:
	grafismos.change_grafismo(7)

func _on_music_button_focus_entered() -> void:
	grafismos.change_grafismo(1)
	move_indicator(music.get_child(3).global_position)

func _on_music_button_focus_exited() -> void:
	grafismos.change_grafismo(7)

func _on_music_button_pressed() -> void:
	grafismos.ignore_exit = true
	music_h_slider.grab_focus()

func _on_music_h_slider_focus_entered() -> void:
	grafismos.change_grafismo(1)
	move_indicator(music.get_child(3).global_position)

func _on_music_h_slider_focus_exited() -> void:
	grafismos.ignore_exit = false
	grafismos.change_grafismo(7)

func _on_music_h_slider_mouse_entered() -> void:
	grafismos.ignore_exit = true
	grafismos.change_grafismo(1)
	move_indicator(music.get_child(3).global_position)
	
func _on_music_h_slider_mouse_exited() -> void:
	grafismos.ignore_exit = false

##########################################################

func _on_sfx_button_mouse_entered() -> void:
	grafismos.change_grafismo(2)
	move_indicator(sfx.get_child(3).global_position)

func _on_sfx_button_mouse_exited() -> void:
	grafismos.change_grafismo(7)

func _on_sfx_h_slider_focus_entered() -> void:
	grafismos.change_grafismo(2)
	move_indicator(sfx.get_child(3).global_position)

func _on_sfx_button_focus_entered() -> void:
	grafismos.change_grafismo(2)
	move_indicator(sfx.get_child(3).global_position)

func _on_sfx_button_focus_exited() -> void:
	grafismos.change_grafismo(7)

func _on_sfx_button_pressed() -> void:
	grafismos.ignore_exit = true
	sfx_h_slider.grab_focus()

func _on_sfx_h_slider_focus_exited() -> void:
	grafismos.ignore_exit = false
	grafismos.change_grafismo(7)

func _on_sfx_h_slider_mouse_entered() -> void:
	grafismos.ignore_exit = true
	grafismos.change_grafismo(2)
	move_indicator(sfx.get_child(3).global_position)

func _on_sfx_h_slider_mouse_exited() -> void:
	grafismos.ignore_exit = false

##########################################################

func _on_lang_button_mouse_entered() -> void:
	grafismos.change_grafismo(3)
	move_indicator(language.get_child(3).global_position)

func _on_lang_button_mouse_exited() -> void:
	grafismos.change_grafismo(7)

func _on_lang_button_focus_entered() -> void:
	grafismos.change_grafismo(3)
	move_indicator(language.get_child(3).global_position)
func _on_lang_button_focus_exited() -> void:
	grafismos.change_grafismo(7)

##########################################################

func _on_main_button_mouse_entered() -> void:
	grafismos.change_grafismo(4)
	move_indicator(main.get_child(2).global_position)

func _on_main_button_mouse_exited() -> void:
	grafismos.change_grafismo(7)

func _on_main_button_focus_entered() -> void:
	grafismos.change_grafismo(4)
	move_indicator(main.get_child(2).global_position)

func _on_main_button_focus_exited() -> void:
	grafismos.change_grafismo(7)

##########################################################

func _on_exit_button_mouse_entered() -> void:
	grafismos.change_grafismo(5)
	move_indicator(exit.get_child(2).global_position)

func _on_exit_button_mouse_exited() -> void:
	grafismos.change_grafismo(7)

func _on_exit_button_focus_entered() -> void:
	grafismos.change_grafismo(5)
	move_indicator(exit.get_child(2).global_position)

func _on_exit_button_focus_exited() -> void:
	grafismos.change_grafismo(7)

##########################################################

func _on_texture_button_mouse_entered() -> void:
	grafismos.change_grafismo(6)
	move_indicator(return_button.get_child(2).global_position)

func _on_texture_button_mouse_exited() -> void:
	grafismos.change_grafismo(7)

func _on_texture_button_focus_entered() -> void:
	grafismos.change_grafismo(6)
	move_indicator(return_button.get_child(2).global_position)

func _on_texture_button_focus_exited() -> void:
	grafismos.change_grafismo(7)

##########################################################

func _on_controls_button_focus_entered() -> void:
	grafismos.change_grafismo(8)
	move_indicator(controls.get_child(1).global_position)


func _on_controls_button_focus_exited() -> void:
	grafismos.change_grafismo(7)


func _on_controls_button_mouse_entered() -> void:
	grafismos.change_grafismo(8)
	move_indicator(controls.get_child(1).global_position)


func _on_controls_button_mouse_exited() -> void:
	grafismos.change_grafismo(7)

func move_indicator(coords) -> void:
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(indicator,"position", coords, 0.1)
	tween.play()
