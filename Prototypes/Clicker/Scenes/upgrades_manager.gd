extends Control

@onready var clicker_m_scene: Control = $".."
@onready var perk_details: Node2D = $"../PerkDetails"
@onready var perk_type_selector: Node2D = $"../PerkDetails/PerkTypeSelector"
@onready var buy: TextureButton = $"../Buy"



var iteration : int
var perks_type_id : int
var all_perks : Array = []
var prev_selected_perk : Node2D
var current_perk_dict : Dictionary

func _ready() -> void:
	update_perks(0, false)
	current_perk_dict = GLOBAL.yellow_perks_info

func update_perks(type_id : int, animated : bool) -> void:
	all_perks.clear()
	perks_type_id = type_id
	if type_id == 0:
		vertical_counting(animated)
	elif type_id == 1:
		vertical_counting(animated)
	elif type_id == 2:
		vertical_counting(animated)
	
func horizontal_counting(animated : bool) -> void: #Ordena los botones horizontalmente
	#Los botones están organizados horizontalmente, por filas. 
	#Se recorre la primera fila, y se nombra cada boton como la iteración local de cada elemento de la fila +1
	#Es decir, primera iteración global: 1, 2, 3, 4
	#Para la siguiente iteración global, se hace lo mismo pero sumando 4 respecto a la iteración anterior
	#Es decir, 5, 6, 7, 8 para la segunda, 9, 10, 11, 12 para la tercera, y así sucesivamente. 
	
	iteration = 0 #Numeramos cada fila
	for hbox in get_child(0).get_children(): #Por cada fila 
		var sub_iter : int = 1 #Numeramos cada columna
		for container in hbox.get_children(): #Obtiene cada contenedor donde se encuentra cada boton
			var perk = container.get_child(0) #Obtiene el botón dentro del contenedor
			var grid_position : int = iteration + sub_iter
			perk.update_info(grid_position, perks_type_id) #Establecemos el nombre
			sub_iter += 1 #Sumamos 1 a la columna para la siguiente iteración
			if perk.im_connected:
				pass
			else:
				perk.im_selected.connect(self._perk_selected)
				perk.im_deselected.connect(self._perk_deselected)
				perk.im_connected = true
			perk.change_textures(animated)
		iteration += 4 #Sumamos 4 (1 por cada columna que hay)
		if animated:
			await get_tree().create_timer(0.05).timeout
		else:
			pass

func vertical_counting(animated : bool) -> void: #Ordena los botones verticalmente
	#Como los botones están organizados horizontalmente
	#Se recorre las filas, pero en vez de haciendo 1, 2, 3, 4 y sumando 4 a cada iteración global, 
	#Se recorre las filas nombrando iteración global + iteración local + 1, sumando tras cada iteración local 6 a la misma.
	#Es decir, fila 1 (iteración global 0): 0+0+1, 0+6+1, 0+12+1, 0+18+1 // 1, 7, 13, 19
	#Para la fila 2 o (iteración global 1): 1+0+1, 1+6+1, 1+12+1, 1+18+1 // 2, 8, 14, 20
	#Para la fila 3 o (iteración global 2): 2+0+1, 2+6+1, 2+12+1, 2+18+1 // 3, 9, 15, 21
	#Y así por cada fila 
	
	var iter = 0 #Iniciamos la iteración global con 0
	for hbox in get_child(0).get_children(): #Por cada fila 
		var sub_iter = 0 #Iniciamos la iteración local con 0
		for container in hbox.get_children(): #Por cada contenedor dentro de cada fila
			var grid_position : int = sub_iter + iter + 1
			var perk = container.get_child(0) #Obtenemos el botón del contenedor
			perk.update_info(grid_position, perks_type_id) #Le nombramos segun la fila y columna en la que esté. 
			sub_iter += 6 #Sumamos 1 por cada fila que hay
			if perk.im_connected:
				pass
			else:
				perk.im_selected.connect(self._perk_selected)
				perk.im_deselected.connect(self._perk_deselected)
				perk.im_connected = true
			perk.change_textures(animated)
		iter += 1 #Por cada fila que se recorre, se suma 1. 
		if animated:
			await get_tree().create_timer(0.05).timeout
		else:
			pass

func _perk_selected(perk : Node2D) -> void:
	if prev_selected_perk:
		prev_selected_perk.deselect_button()
	else:
		pass
	prev_selected_perk = perk
	perk_details.change_perk()
	
func _perk_deselected(_perk : Node2D) -> void:
	prev_selected_perk = null
	perk_details.change_perk()


func _on_perk_type_selector_perk_type_1() -> void:
	update_perks(0, true)
	current_perk_dict = GLOBAL.yellow_perks_info
	if prev_selected_perk:
		prev_selected_perk.deselect_button()
		prev_selected_perk = null

func _on_perk_type_selector_perk_type_2() -> void:
	update_perks(1, true)
	current_perk_dict = GLOBAL.blue_perks_info
	if prev_selected_perk:
		prev_selected_perk.deselect_button()
		prev_selected_perk = null
	
func _on_perk_type_selector_perk_type_3() -> void:
	update_perks(2, true)
	current_perk_dict = GLOBAL.red_perks_info
	if prev_selected_perk:
		prev_selected_perk.deselect_button()
		prev_selected_perk = null


func _on_button_pressed() -> void:
	var perk_dict : Dictionary = current_perk_dict.get(str(prev_selected_perk.my_key))
	var next_perk_dict : Dictionary = current_perk_dict.get(str(prev_selected_perk.my_key + 1))
	
	perk_dict.set("bought", true)
	perk_dict.get("my_button").manage_unlocked()
	if next_perk_dict.get("my_button"):
		next_perk_dict.set("available", true)
		next_perk_dict.get("my_button").animate_lock()
		
	else:
		pass
	perk_details.change_perk()
	update_active_effects()
	clicker_m_scene.float_points -= prev_selected_perk.my_price
	
func update_active_effects() -> void:
	if prev_selected_perk.my_type == 0:
		GLOBAL.total_yellow = 0
		GLOBAL.active_yellow_perks.append(prev_selected_perk.my_dict.get("value"))
		for i in GLOBAL.active_yellow_perks:
			GLOBAL.total_yellow += i
	
	elif prev_selected_perk.my_type == 2:
		GLOBAL.total_red = 0
		GLOBAL.active_red_perks.append(prev_selected_perk.my_dict.get("value"))
		for i in GLOBAL.active_red_perks:
			GLOBAL.total_red += i
	
	elif prev_selected_perk.my_type == 3:
		var perk_subtype : int = prev_selected_perk.my_dict.get("subtype")
		if perk_subtype == 1:
			GLOBAL.total_yellow += (GLOBAL.total_yellow * prev_selected_perk.my_dict.get("value"))
			
		elif perk_subtype == 2:
			GLOBAL.total_red += (GLOBAL.total_red * prev_selected_perk.my_dict.get("value"))
			
		elif perk_subtype == 3:
			pass #mejora estadisticas de las piezas de las naves
		
		elif perk_subtype == 4:
			pass #desbloquea una pieza para la nave

func _process(delta: float) -> void:
	if prev_selected_perk:
		if prev_selected_perk.my_dict.get("bought") or clicker_m_scene.float_points < prev_selected_perk.my_price:
			buy.disabled = true
		else:
			buy.disabled = false
	else:
		buy.disabled = true
