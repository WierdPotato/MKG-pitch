extends Control
#######################################
#variables
@onready var countdown: Timer = $Countdown
@onready var clock: Label = $Clock/ClockLBL

@export var prep_menu : PackedScene
@export var clicker_minutes : float = 2
@export var float_points : float

var total_points : int
var points_per_click : float
var click_point_value : int = 1
var click_percentage_amm : float
var points_per_second : float
var auto_point_value : int = 0
var auto_percentage_amm : float

func _ready() -> void:
	float_points = GLOBAL.money
	points_per_click = 1
	points_per_second = 0
	auto_percentage_amm = 0
	countdown.start(60 * clicker_minutes)

#######################################
#Manager de botones

func button_manager() -> void: 
	if total_points < 20:
		$UpgradeManager/Upgrade1.disabled = true
	else:
		$UpgradeManager/Upgrade1.disabled = false

	if total_points < 100:
		$UpgradeManager/Upgrade2.disabled = true
	else:
		$UpgradeManager/Upgrade2.disabled = false

	if total_points < 500 or auto_point_value <= 0:
		$UpgradeManager/Upgrade3.disabled = true
	else:
		$UpgradeManager/Upgrade3.disabled = false

	if total_points < 250:
		$UpgradeManager/Upgrade4.disabled = true
	else:
		$UpgradeManager/Upgrade4.disabled = false


#######################################
#Cambio de texto/información
	$CPS.text = "Total Points: " + str(total_points)
	#Toma un integer y lo convierte en un string, en este caso, la variable ClicksPorSegundo
	$PPS.text = "Autoclicks per second: " + str(points_per_second)
	#Toma un integer y lo convierte en un string, en este caso, la variable PuntosPorSegundo
	
#######################################
#Señales y funciones
func _on_main_clicker_button_down() -> void:
	float_points += points_per_click

func _on_upgrade_1_button_down() -> void:
	float_points -= 20
	click_point_value += 1

func _on_upgrade_2_button_down() -> void:
	float_points -= 100
	auto_point_value += 10

func _on_upgrade_3_button_down() -> void:
	float_points -= 500
	autopoints_percentage(25)

func _on_upgrade_4_pressed() -> void:
	float_points -= 250
	clicks_percentage(25)

###########
#Gestiona las bonificaciones de porcentaje a los puntos obtenidos automaticamente
func autopoints_percentage(percentage : int) -> void:
	auto_percentage_amm += percentage 
	print("Porcentaje aumentado: ", auto_percentage_amm / 100)

###########
#Gestiona las bonificaciones de porcentaje a los puntos obtenidos clickando
func clicks_percentage(percentage : int) -> void:
	click_percentage_amm += percentage
	print("Porcentaje aumentado: ", auto_percentage_amm / 100)

###################
#Gestiona los puntos
func manage_points() -> void:
	#Aplica las bonificaciones por porcentaje a cada tipo de 
	points_per_second = auto_point_value + (auto_percentage_amm / 100)
	points_per_click = click_point_value + (click_percentage_amm / 100)
	#Redondea los puntos reales hacia abajo y le muestra el redondeo al jugador
	total_points = floori(float_points)
	
#######################################
#Timer de PPS
func _on_timer_timeout() -> void:
	float_points += points_per_second

#Timer con la duración del clicker
func _on_countdown_timeout() -> void:
	get_tree().change_scene_to_packed(prep_menu)
	GLOBAL.money += total_points


func _process(_delta: float) -> void:
	#button_manager()
	#manage_points()
	#$DebugLabels/DebugLabel1.text = "Points per second: " + str(points_per_second)
	#$DebugLabels/DebugLabel2.text = "Points per click: " + str(points_per_click)
	#$"DebugLabels/Float Points".text = "Real Points: " + str(float_points)
	clock.text = str(int(round(countdown.time_left)))
#balanceos y demás.
