extends Attribute
class_name Infernal

func _init() -> void:
	type = "onRoom"
	name = "Infernal"
	description = " The great Unholy Kings embodied their realms. To fight them is to fight a concept, and so they were sealed. You too now, embody fire.
	
	Burn every enemy every time you enter an undiscovered room.
	
	None shall seal you."

func effect(target : Node):
	var s = preload("res://scenes/Projectiles/Sprites/sample_anim.tscn")
	var j = WeaponList.createNewAOE(s.instantiate(), Vector2(22,22), Vector2(0,0), 'fire', 0, 'burn', 1.0)
	EventBus.throwEffect.emit(j)
