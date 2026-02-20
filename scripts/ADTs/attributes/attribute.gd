extends RefCounted
class_name Attribute

var type: String
var name: String
var description: String
var damageType: String

func _init() -> void:
	pass

func check(target: DungeonController):
	pass

func onPickup(target : Node):
	pass

func special(target: Node) -> int:
	return 0

func effect(target: Node) -> int:
	return -1
