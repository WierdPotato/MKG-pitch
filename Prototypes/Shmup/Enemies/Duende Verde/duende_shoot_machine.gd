extends Node2D

@export var shot : PackedScene
@export var my_hit_dmg : int

@onready var shot_cd: Timer = $ShotCD
@onready var marker_2d: Marker2D = $Marker2D


var player_in_range : bool
var alive : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shot_cd.start(randf_range(1, 2))

func activate() -> void:
	#shot_cd.start(randf_range(1, 2))
	pass

func _on_shot_cd_timeout() -> void:
	if alive:
		var shot_instance = shot.instantiate() #Instancia la escena con el disparo
		shot_instance.global_position = marker_2d.global_position #Establece la posición del disparo a la del marcador. 
		shot_instance.current_vector = Vector2(-1, 0)
		shot_instance.hit_damage = my_hit_dmg
		get_tree().call_group("Level", "add_child", shot_instance)
		shot_cd.start(randf_range(0.5, 2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
