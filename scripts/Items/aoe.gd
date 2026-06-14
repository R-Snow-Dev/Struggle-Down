extends WeaponEffect
class_name AOE

var sprite: AnimatedSprite2D
var dim: Vector2
var offset: Vector2
var facing = Vector2(0,1)
@onready var aoe = $CollisionShape2D

func setVars(s: AnimatedSprite2D, d: Vector2, o: Vector2):
	sprite = s
	dim = d
	offset = o
	
func _ready() -> void:
	aoe.scale = dim
	global_position += (offset.y*16) * Vector2(facing)
	sprite.rotation_degrees = 180
	add_child(sprite)
	EventBus.pause.emit()
	await sprite.animation_finished
	EventBus.unpause.emit()
	call_deferred("queue_free")
