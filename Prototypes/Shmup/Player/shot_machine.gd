extends Node

@onready var label: Label = $Label
@onready var reload_time_lbl: Label = $ReloadTimeLbl
@onready var reload_timer: Timer = $ReloadTimer

@onready var shot_spawn: Marker2D = $Marker2D
@onready var shot_cd: Timer = $ShotCD

@export var shot : PackedScene
@export var ammo : int 
@export var cadence : float
@export var max_chamber : int
var chamber : int

signal reload_started

var reload_machine
var reloading : bool
var can_shoot : bool = true

var early_reload : float = 0.75
var perfect_reload : float = 0.1
var late_reload : float = 1.25
var missed_reload : float = 2

var alive : bool

func _ready() -> void:
	alive = true
	ammo = PREP.ship_ammo
	cadence = PREP.ship_cadence
	if ammo >= max_chamber:
		chamber = max_chamber
	else:
		chamber = ammo
	manage_info(1)

func process_shot() -> void:
	if Input.is_action_pressed("Shoot"):
		if can_shoot == true and ammo > 0 and cadence > 0 and chamber > 0 and alive:
			var shot_instance = shot.instantiate() #Instancia la escena con el disparo
			shot_instance.player_node = get_parent()
			shot_instance.global_position = shot_spawn.global_position #Establece la posición del disparo a la del marcador. 
			get_tree().call_group("Level", "add_child", shot_instance) #Añade el disparo a la escena que está en el grupo Level.
			#Así las balas se mueven solo hacia alante y no se desplazan cuando movemos la nave. 
			shot_cd.start(shot_cadence())
			ammo -= 1
			manage_chamber()
			can_shoot = false
		else:
			pass

func check_reload() -> void:
	if Input.is_action_just_pressed("Reload") and reloading == false and alive and ammo > 0:
		chamber = 0
		reload_machine.reload_pressed()
		manage_info(2)

func manage_chamber()-> void:
	chamber -= 1
	if chamber == 0 and ammo > 0:
		reload_machine.reload_pressed()
		manage_info(2)
	else:
		manage_info(1)

func reload(tier : int) -> void:
	reloading = true
	if tier == 1: #Recargado muy pronto
		print("Recarga temprana")
		manage_timer_info(3)
		can_shoot = false
		await get_tree().create_timer(early_reload).timeout
		can_shoot = true
		apply_reload()
		reloading = false

	elif tier == 2: #Recarga perfecta
		manage_timer_info(4)
		can_shoot = false
		await get_tree().create_timer(perfect_reload).timeout
		can_shoot = true
		apply_reload()
		reloading = false

	elif tier == 3: #Recarga lenta
		manage_timer_info(5)
		can_shoot = false
		await get_tree().create_timer(late_reload).timeout
		can_shoot = true
		apply_reload()
		reloading = false

	else: #Se te caen las balar
		manage_timer_info(6)
		can_shoot = false
		await get_tree().create_timer(missed_reload).timeout
		can_shoot = true
		apply_reload()
		reloading = false
 
func apply_reload() -> void:
	if ammo >= max_chamber:
		chamber = max_chamber
	else:
		chamber = ammo

func add_ammo(ammount) -> void:
	ammo += ammount
	if ammo == ammount:
		print("Autoload")
		reload_machine.reload_pressed()

func manage_info(message_id : int) -> void:
	if message_id == 1:
		label.text = str(chamber)
		
	elif message_id == 2:
		label.text = "RELOADING"

func manage_timer_info(message_id : int) -> void:
	print("manage timer info called ", message_id)
	if message_id == 3: #Early reload
		print("3 called")
		#reload_time_lbl.visible = true
		await get_tree().process_frame
		label.text = "TOO SOON"
		print(label.text)
		reload_timer.wait_time = early_reload
		reload_timer.start()
		
	elif message_id == 4: #Perfect reload
		print("4 called")
		#reload_time_lbl.visible = true
		#label.text = "PERFECT!"
		reload_timer.wait_time = perfect_reload
		reload_timer.start()
		
	elif message_id == 5: #Late reload
		print("5 called")
		#reload_time_lbl.visible = true
		await get_tree().process_frame
		label.text = "TOO LATE"
		print(label.text)
		reload_timer.wait_time = late_reload
		reload_timer.start()
	
	elif message_id == 6: #Missed reload
		print("6 called")
		#reload_time_lbl.visible = true
		label.text = "MISSED"
		print(label.text)
		reload_timer.wait_time = missed_reload
		reload_timer.start()
	reload_started.emit()

func _on_reload_timer_timeout() -> void:
	reload_time_lbl.visible = false
	manage_info(1)


func _on_cadence_timeout() -> void:
	can_shoot = true

func shot_cadence() -> float:
	var cd : float
	cd = 1/cadence
	return cd

func _process(_delta: float) -> void:
	process_shot()
	check_reload()
