extends Node

@export var shot : PackedScene
@export var ammo : int 
@export var cadence : float

@onready var shot_spawn: Marker2D = $Marker2D
@onready var shot_cd: Timer = $ShotCD

var can_shoot : bool = true

func _ready() -> void:
	ammo = PREP.ship_ammo
	cadence = PREP.ship_cadence
func process_shot() -> void:
	if Input.is_action_pressed("Shoot"):
		if can_shoot == true and ammo > 0 and cadence > 0 :
			var shot_instance = shot.instantiate() #Instancia la escena con el disparo
			shot_instance.global_position = shot_spawn.global_position #Establece la posición del disparo a la del marcador. 
			get_tree().call_group("Level", "add_child", shot_instance) #Añade el disparo a la escena que está en el grupo Level.
			#Así las balas se mueven solo hacia alante y no se desplazan cuando movemos la nave. 
			shot_cd.start(shot_cadence())
			ammo -= 1
			can_shoot = false
		else:
			pass

func _on_cadence_timeout() -> void:
	can_shoot = true

func shot_cadence() -> float:
	var cd : float
	cd = 1/cadence
	return cd

func _process(_delta: float) -> void:
	process_shot()
