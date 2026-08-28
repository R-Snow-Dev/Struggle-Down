extends Node2D
class_name DelayedAOE

var sp: Node
var size: Vector2 = Vector2(1,1)
var dT: String
var a: int
var sE: String = 'none'
var c: float = 0.0 


func setSize(s: Vector2) -> void:
	size = s

func setSprite(s: Node) -> void:
	sp = s

func setType(data: String) -> void:
	dT = data

func setEffect(data: String) -> void:
	sE = data
	
func setDamage(data: int) -> void:
	a = data

func setChance(data: float) -> void:
	c = data

func _ready() -> void:
	await EventBus.playersTurnStart
	print(str(get_parent()))
	EventBus.pause.emit()
	var j = WeaponList.createNewAOE(sp, size, Vector2(0,0), dT, a, sE, c)
	add_child(j)
	print(str(j.global_position))
	await EventBus.over
	call_deferred("queue_free")
