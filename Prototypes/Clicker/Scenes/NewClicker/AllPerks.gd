extends VBoxContainer

const BUBBLE_AMARILLO = preload("uid://irr0ffukfmyc")
const BUBBLE_AZUL = preload("uid://dts0x8o184n8j")
const BUBBLE_VERDE = preload("uid://cn8wu0ovcfos3")

var all_buttons : Array = []
var current_button : TextureButton

@export var real_random : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var list : Array = [BUBBLE_AMARILLO, BUBBLE_AZUL, BUBBLE_VERDE]
	var hbox_iter = 1
	if real_random:
		for i in get_children():
			for b in i.get_children():
				var my_pick = list.pick_random()
				b.texture_normal = my_pick
	else:
		for i in get_children():
			var prev_pick 
			var iter : int = 1
			for b in i.get_children():
				var my_pick = list.pick_random()
				if prev_pick:
					if prev_pick == my_pick:
						var aux_list : Array = list.duplicate()
						aux_list.erase(my_pick)
						my_pick = aux_list.pick_random()
				b.texture_normal = my_pick
				b.my_x = iter
				b.my_y = hbox_iter
				b.im_set()
				all_buttons.append(b)
				prev_pick = my_pick
				iter += 1
			hbox_iter += 1
	for i in all_buttons:
		i.get_my_friends(all_buttons)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("Buy"):
		buy()

func _on_buy_pressed() -> void:
	buy()

func buy()-> void:
	if current_button:
			current_button.im_unlocked = true
			show_perks(current_button.friends)

func show_perks(friends : Array) -> void:
	for i in friends:
		if i:
			i.disabled = false
		else:
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
