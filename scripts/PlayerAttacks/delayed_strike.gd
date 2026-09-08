extends Node2D
class_name DelayedStrike

var id: int = 0
var sp: Node
var lf: float = 0.1
var size: Vector2 = Vector2(0.5,0.5)

func setSize(s: Vector2) -> void:
	size = s

func setId(i: int) -> void:
	id = i

func setSprite(s: Node) -> void:
	sp = s
	
func setLifespan(amount: float) -> void:
	lf = amount

func _ready() -> void:
	await EventBus.playersTurnStart
	print(str(get_parent()))
	EventBus.pause.emit()
	var hBox: Hurtbox = preload("res://scenes/DungeonParts/hurtbox.tscn").instantiate()
	hBox.setSprite(sp)
	hBox.setLifespan(lf)
	hBox.setup(WeaponList.weapons[id], 0)
	hBox.scale = size
	add_child(hBox)
	print(str(hBox.global_position))
	await EventBus.playerDoneAttacking
	call_deferred("queue_free")
	
