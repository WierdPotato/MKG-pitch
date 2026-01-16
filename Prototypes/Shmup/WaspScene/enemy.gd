extends Node2D

@export var speed : int = 100
@export var hp : float

@onready var sprite_2d: AnimatedSprite2D = $Area2D/Sprite2D

var crash_damage : float = 90
var hit_points_value = 10

func _ready() -> void:
	sprite_2d.play("default")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		hp -= PREP.selected_parts_dict["wpn"].get("Damage")
		get_parent().current_points += hit_points_value
		self.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_child(0).integrity -= crash_damage
		self.queue_free()

func _process(delta: float) -> void:
	global_position.x -= speed * delta
	
	if hp <= 0:
		self.queue_free()
