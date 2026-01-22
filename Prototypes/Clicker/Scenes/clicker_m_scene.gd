extends Control
#######################################
#variables
@onready var countdown: Timer = $Countdown
@onready var timer: Timer = $Timer

@onready var clock: Label = $Clock/ClockLBL
@onready var money_per_second_lbl: Label = $MoneyPerSecond/MoneyPerSecondLBL
@onready var total_money_lbl: Label = $TotalMoney/TotalMoneyLBL
@onready var perk_type_selector: Node2D = $PerkDetails/PerkTypeSelector
@onready var upgrades_manager: Control = $UpgradesManager
@onready var buy: TextureButton = $Buy

@export var cheat : bool

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
	if cheat:
		float_points = 99999
	else:
		float_points = GLOBAL.money
	points_per_click = 1
	points_per_second = 0
	auto_percentage_amm = 0
	countdown.start(60 * clicker_minutes)
#######################################
#Señales y funciones
func _on_main_clicker_button_down() -> void:
	update_click_points()
	
func _on_timer_timeout() -> void:
	float_points += GLOBAL.total_red
	
func update_click_points() -> void:
	float_points += (points_per_click + GLOBAL.total_yellow)

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


#Timer con la duración del clicker
func _on_countdown_timeout() -> void:
	pass
	#timer.stop()
	#get_tree().change_scene_to_packed(prep_menu)

func _input(event: InputEvent) -> void:
	
	if Input.is_action_pressed("Change") and perk_type_selector.button.disabled == false:
		perk_type_selector._on_button_pressed()
		
	elif Input.is_action_just_released("Click"):
		update_click_points()
		
	elif Input.is_action_pressed("Buy") and buy.disabled == false:
		upgrades_manager._on_button_pressed()

func _process(_delta: float) -> void:
	GLOBAL.money = total_points
	manage_points()
	money_per_second_lbl.text = str(GLOBAL.total_red)
	total_money_lbl.text = str(total_points)
	clock.text = str(int(round(countdown.time_left)))
#balanceos y demás.
