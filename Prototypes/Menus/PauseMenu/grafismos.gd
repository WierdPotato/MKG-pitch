extends Node2D

@onready var music: Sprite2D = $Music
@onready var sfx: Sprite2D = $SFX
@onready var language: Sprite2D = $Language
@onready var main: Sprite2D = $Main
@onready var exit: Sprite2D = $Exit
@onready var neutral: Sprite2D = $Neutral
@onready var return_graf: Sprite2D = $Return

var ignore_exit : bool
var current_grafismo : Sprite2D

func _ready() -> void:
	current_grafismo = neutral

func change_grafismo(id : int) -> void:
	await get_tree().process_frame
	
	var my_grafismo : Sprite2D
	if id == 1:
		my_grafismo = music
		
	elif id == 2:
		my_grafismo = sfx
	
	elif id == 3:
		my_grafismo = language
	
	elif id == 4:
		my_grafismo = main
	
	elif id == 5:
		my_grafismo = exit
	
	elif id == 6:
		my_grafismo = return_graf
	
	elif id == 7:
		my_grafismo = neutral
	
	if current_grafismo == my_grafismo or ignore_exit == true:
		pass
	else:
		await animate_change(current_grafismo, true)
		current_grafismo.visible = false
		manage_grafismo(my_grafismo)

func animate_change(grafismo : Sprite2D, reduce : bool) -> bool:
	
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	if reduce:
		tween.tween_property(grafismo, "scale", Vector2(0, 0), 0.1)
	else:
		tween.tween_property(grafismo, "scale", Vector2(1, 1), 0.1)
		
	tween.play()
	await tween.finished
	return true

func manage_grafismo(grafismo)-> void:
	grafismo.scale = Vector2(0,0)
	grafismo.visible = true
	animate_change(grafismo, false)
	current_grafismo = grafismo
