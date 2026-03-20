extends Area2D

@onready var butano_boss: Node2D = $".."
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shield_collision: CollisionPolygon2D = $ShieldCollision
@onready var shield_active: Timer = $ShieldActive
@onready var shield_inactive: Timer = $ShieldInactive
@onready var hurt_timer: Timer = $HurtTimer

@export var tick_dmg : float = 2

var activated : bool
var player_in : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func activate() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "self_modulate", Color(1.0, 1.0, 1.0, 1.0), 3)
	await tween.finished
	shield_collision.disabled = false
	shield_active.start(13)

func deactivate() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "self_modulate", Color(1.0, 1.0, 1.0, 0.0), 3)
	await tween.finished
	shield_collision.disabled = true
	shield_inactive.start(7)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in = true
		butano_boss.emit_signal("intruder")
		
func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in = false
		butano_boss.emit_signal("cleared")

func _on_hurt_timer_timeout() -> void:
	if player_in:
		hurt_player()

func hurt_player()-> void:
	butano_boss.player.get_child(0).integrity -= tick_dmg

func _on_shield_active_timeout() -> void:
	deactivate()
	
func _on_shield_inactive_timeout() -> void:
	activate()
