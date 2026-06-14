extends BoardEntity
class_name BombEntity

var dam: int
var dType: String
var sprite: AnimatedSprite2D
var facing: Vector2
var explosion: Explosion = preload("res://scenes/DungeonParts/explosion.tscn").instantiate()
var exploded = false

func setup(s: AnimatedSprite2D, d: int, dT: String):
	sprite = s
	dam = d
	dType = dT

func explode():
	if !exploded:
		exploded = true
		explosion.setDam(dam)
		explosion.setType(dType)
		sprite.visible=false
		add_child(explosion)
		await explosion.end
		call_deferred('queue_free')

func _kill():
	call_deferred('queue_free')

func _ready() -> void:
	position += 16 * facing
	EventBus.playersTurnStart.connect(explode)
	EventBus.killEntities.connect(_kill)
	add_child(sprite)
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	explode()
