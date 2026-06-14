extends BoardEntity
class_name TrapEntity

@onready var trap: WildDamage = $Area2D
var sprite: AnimatedSprite2D
var dam: int
var dType: String
var effect: String
var chance: float
var facing: Vector2

func setup(s: AnimatedSprite2D, d:int, dT:String, e: String, c: float):
	sprite = s
	dam = d
	dType = dT
	effect = e
	chance = c

func _kill():
	call_deferred('queue_free')

func _ready() -> void:
	trap.setDam(dam)
	trap.setEffect(effect)
	trap.setType(dType)
	trap.setChance(chance)
	position += 16 * facing
	EventBus.killEntities.connect(_kill)
	add_child(sprite)
