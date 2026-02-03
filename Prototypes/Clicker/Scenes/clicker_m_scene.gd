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
@onready var main_clicker: TextureButton = $MainClicker
@onready var main_clicker_aux: Sprite2D = $MainClickerAux

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
	timer.wait_time = 1 - GLOBAL.total_red_cd_reduction
	float_points += GLOBAL.total_red + (GLOBAL.total_red * GLOBAL.total_pcn_red)
	
func update_click_points() -> void:
	float_points += points_per_click + GLOBAL.total_yellow + (GLOBAL.total_yellow * GLOBAL.total_pcn_yellow) + (GLOBAL.money * GLOBAL.total_gen_pcn_yellow)
	
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	tween.tween_property(main_clicker_aux,"scale", Vector2(0, 0), 0.05) #Y cambiamos la velocidad en base al tiempo obtenido en la formula.
	tween.play()
	await tween.finished
	tween.stop()
	tween.tween_property(main_clicker_aux,"scale", Vector2(1, 1), 0.05)
	tween.play()
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
	total_points = floori(float_points)
	GLOBAL.money = total_points
#######################################
#Timer de PPS


#Timer con la duración del clicker
func _on_countdown_timeout() -> void:
	pass
	timer.stop()
	get_tree().change_scene_to_packed(prep_menu)

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_pressed("Change") and perk_type_selector.button.disabled == false:
		perk_type_selector._on_button_pressed()
		
	elif Input.is_action_just_released("Click"):
		update_click_points()
		
	elif Input.is_action_pressed("Buy") and buy.disabled == false:
		upgrades_manager._on_button_pressed()

func _process(_delta: float) -> void:
	$Joker1/Joker1LBL.text =  str(GLOBAL.total_yellow) + "//" + str((GLOBAL.total_yellow * GLOBAL.total_pcn_yellow)) +"//" + str((GLOBAL.money * GLOBAL.total_gen_pcn_yellow))
	manage_points()
	$Joker1/Label.text = str(GLOBAL.ignore_call)
	money_per_second_lbl.text = str(GLOBAL.total_red)
	total_money_lbl.text = str(total_points)
	clock.text = str(int(round(countdown.time_left)))
#balanceos y demás.
