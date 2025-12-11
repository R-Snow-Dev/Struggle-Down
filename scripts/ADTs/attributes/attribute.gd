extends RefCounted
class_name Attribute

var type: String
var name: String
var description: String
var damageType: String

func _init() -> void:
	pass

func onPickup(target : Node):
	pass

func effect(target: Node) -> int:
	return -1
