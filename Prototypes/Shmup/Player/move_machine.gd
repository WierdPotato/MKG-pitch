extends Node2D

@onready var sprite: Sprite2D = $"../Sprite" #Nodo sprites de la nave
@onready var screensize = get_viewport_rect().size
@onready var player: Player = $".."


var Vmn : int #Velocidad inicial VALOR BASE: 0
var Vmx : int #Velocidad maxima VALOR BASE: 350
var Tm : float #Tiempo de cambio de velocidad
var Vf : float #Velocidad objetivo
var Viy : float #Velocidad inicial en eje y
var Vix : float #Velocidad inicial en eje y
var Fz : int #Fuerza de empuje VALOR BASE: 25
var Mu : float #Densidad del aire VALOR BASE: 1.2
var Ms : float #Masa VALOR BASE: 3
var Ar : float #Superficie de la nave VALOR BASE: 2


var axis : Vector2 #Almacena el vector que introduce el jugador
var Vs : float #Velocidad Vertical
var Hs : float #Velocidad Horizontal
var vectors : Array = [Vector2(0,0), Vector2(0,0)] #Almacena los dos ultimos vectores que el jugador a introducido
var current_x_tween : Tween #Almacena el último tween de velocidad.x que se ha ejecutado 
var current_y_tween : Tween #Almacena el último tween de velocidad.y que se ha ejecutado 

#Archivos con los sprites de la nave
const ship_normal = preload("uid://bil3db0tu5eag")
const ship_down = preload("uid://dpimr02fn8pf")
const ship_up = preload("uid://djpdsrsql7keq")

func _ready() -> void:
	Vmn = 0
	Vmx = PREP.ship_max_speed
	Fz = PREP.ship_force
	Mu = PREP.air_density
	Ms = PREP.ship_mass
	Ar = PREP.ship_area
	

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")) #Obtiene el vector en base a los inputs
	axis.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))

	check_vectors(axis) #Llama al método que comprueba si se ha cambiado de vector
	return axis #Devuelve el vector cuando get_axis() es llamado

func check_vectors(input) -> void:
	if vectors[vectors.size()-1] == input: #Comprueba si el vector recibido es igual al ultimo almacenado
		pass
	else: #Si es diferente:dw
		vectors.append(input) #Añade el vector al array
		if vectors.size() > 2: #Si la lista tiene más de 2 entradas, elimina la más antigua
			vectors.erase(vectors[0])
		
		if vectors[0].x != vectors[1].x and axis.x != 0: #Si las componentes x del primer y segundo vector son diferentes y vector.x no es 0
			accel_tween(2) #Detecta que se debe de cambiar de velocidad x y llama al metodo que gestiona el cambio
			print("X CHANGED")
			
		elif vectors[0].x != vectors[1].x and axis.x == 0: #Si las componentes x son diferentes pero vector.x es 0, reduce la velocidad a 0
			stop_tween(2) 
			print("X STOP")
			
		if vectors[0].y != vectors[1].y and axis.y != 0: 
			accel_tween(1)
			print("Y CHANGED")
			
		elif vectors[0].y != vectors[1].y and axis.y == 0:
			stop_tween(1)
			print("Y STOP")
	

func time_sim(comp : float, Ax : String) -> float: #Ejecuta la formula que determina el tiempo que tarda la nave en cambiar de velocidad
	Vf = (Vmx * comp) #Iguala la velocidad final a la velocidad maxima por el componente. Así podemos obtener la velocidad negativa si es necesario. 
	
	if Ax == "x": #Comprueba si la velocidad que hay que cambiar es en el eje x o y
		
#Tm representa el tiempo que tadará en alcanzar la velocidad objetivo
#Vf es la velocidad objetivo. Vix o Viy son la velocidad que tiene la nave cuando empieza a alcanzar la velocidad objetivo.
#Fz representa al fuerza con la que los motores impulsan la nave. A mayor fuerza, más rapido cambia de velocidad. Está al cuadrado
#Mu representa el rozamiento del aire sobre la nave. A mayor rozamiento, más tarda en alcanzar la velocidad objetivo.
#Ms representa la masa de la nave. A más masa, mas tarda en alcanzar la velocidad. 
		
		Tm = (((Vf-Vix)*(Ms + (Mu*Ar)))/(Fz*Fz*Fz))*(Ms*Ms)
		#Tm = (((Vf-Vix)/(Fz*Fz))*Mu)*Ms 
		if Tm < 0: #Si el tiempo es negativo la formula pierde valor, así que si ocurre, la hacemos positiva. 
			Tm = -Tm 
		
	elif Ax == "y":
		Tm = (((Vf-Viy)*(Ms + (Mu*Ar)))/(Fz*Fz*Fz))*(Ms*Ms)
		#Tm = (((Vf-Viy)/(Fz*Fz))*Mu)*Ms
		if Tm < 0:
			Tm = -Tm
	$"../Label".text = "Time: " + str(Tm)
	return Tm #Devolvemos el tiempo que tardará la nave en alcanzar la velocidad objetivo

func update_vi() -> void: #Actualizamos en cada frame la velocidad incial de la nave segun su velocidad actual. 
	Vix = player.velocity.x 
	Viy = player.velocity.y 

func accel_tween(id) -> void: #Método que ejecuta los tweens que modifican la velocidad de la nave
	if id == 1: #Dependiendo del Id que recibamos, cambia la velocidad vertical o la horizontal
		if current_y_tween: #Si hay un tween activado cambiando la velocidad, lo paramos para sobreescribirlo y evitar errores. 
			current_y_tween.stop()
			pass
			
		var tween : Tween = get_tree().create_tween() #Creamos el tween
		tween.tween_property(self,"Vs", Vf, time_sim(axis.y, "y")) #Y cambiamos la velocidad en base al tiempo obtenido en la formula.
		tween.play()
		current_y_tween = tween #Indicamos que el tween que se está ejecutando ahora es el que acabamos de crear. 
		
	elif id == 2:
		if current_x_tween:
			current_x_tween.stop()
			pass
			
		var tween : Tween = get_tree().create_tween()
		tween.tween_property(self,"Hs", Vf, time_sim(axis.x, "x"))
		tween.play()
		current_x_tween = tween
	
func stop_tween(id) -> void: #Igual que accel_tween, pero la velocidad objetivo es 0 para parar la nave. 
	if id == 1:
		if current_y_tween:
			current_y_tween.stop()
			pass
			
		var tween : Tween = get_tree().create_tween()
		tween.tween_property(self,"Vs", Vmn, time_sim(0, "y"))
		tween.play()
		current_y_tween = tween
		
	elif id == 2:
		if current_x_tween:
			current_x_tween.stop()
		var tween : Tween = get_tree().create_tween()
		tween.tween_property(self,"Hs", Vmn, time_sim(0, "x"))
		tween.play()
		current_x_tween = tween

func manage_mov() -> void: #Gestiona el movimiento de la nave
	if get_axis().y > 0: #Comprueba el la dirección en la que se mueve la nave y cambia el sprite acorde. 
		sprite.texture = ship_down
	elif get_axis().y < 0:
		sprite.texture = ship_up
	else:
		sprite.texture = ship_normal
		
	player.velocity.x = Hs #Igualamos velocity a la velocidad que está alterando el tween.
	player.velocity.y = Vs
	
	player.move_and_slide() #Metodo predefinido de Godot que mueve la nave acorde a velocity
	
	#Establece los límites de la pantalla y evita que la nave supere esos limites.
	player.position.x = clamp(position.x, 40, screensize.x - 40)
	player.position.y = clamp(position.y, 20, screensize.y - 20)
	
	if position.x == screensize.x - 40 or position.x == 40: #Comprueba si ela nave se encuentra en los limites
		if player.velocity.x != 0: #Si velocity no es ya 0
			Hs = 0 #Asegura que velocity concuerde con lo que ve el jugador. 
	
	if position.y == screensize.y - 20 or position.y == 20:
		if player.velocity.y != 0:
			Vs = 0

func _process(_delta: float) -> void:
	update_vi() #Llama cada frame a que se actualicen las velocidades iniciales
	manage_mov() #Gestiona cada frame el movimiento
