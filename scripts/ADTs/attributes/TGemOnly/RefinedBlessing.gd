extends Attribute
class_name RefinedBlessing

var s = preload("res://scenes/Projectiles/Sprites/sample_anim.tscn")


func _init() -> void:
	type = "onRoom"
	name = "Static Cascade"
	description = "You recieve a coalescence of the Elctromagnetic Force.
	
	Stun every enemy every time you enter an undiscovered room.
	
	You are a fundamental force."

func effect(target : Node):
	var j = WeaponList.createNewAOE(s.instantiate(), Vector2(22,22), Vector2(0,0), 'shock', 0, 'stun', 1.0)
	EventBus.throwEffect.emit(j)
