extends Node
class_name AttackBehavior

var dam: int
var attacker: PackedScene

func _init(damage: int, atker: PackedScene) -> void:
	dam = damage
	attacker = atker

func attack():
	pass
	
