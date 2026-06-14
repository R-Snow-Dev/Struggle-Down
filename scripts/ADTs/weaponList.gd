extends Node
class_name Armory

var weapons = [[],
	Weapon.new("Sword","slash",7,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true, Attribute.new(), Attribute.new()),
	Weapon.new("Great Sword","slash",10,2,Vector2(0,1),Vector2i(3,2),Vector2(0,0),true, Attribute.new(), Attribute.new()),
	Weapon.new("Mace","blunt",5,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), MaceMult.new()),
	Weapon.new("Spear","pierce",7,1,Vector2(0,1),Vector2i(1,3),Vector2(0,0),true, Attribute.new(), Attribute.new()),
	Weapon.new("Halberd","slash",5,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true, StanceChange.new(), Attribute.new()),
	Weapon.new("Stiletto","pierce",3,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), DexterityCheck.new())]

var inherentEffects = {
	"slash": {},
	"pierce": {},
	"blunt": {},
	"shockwave": {},
	"frost": {},
	"explosive": {},
	"shock": {},
	"fire": {},
	"holy": {}
}

var mult = 0.75

var enraged: int = 0

var damages = {"slash" = 0, "pierce" = 0, "blunt" = 0, "shockwave" = 0,
"frost" = 0, "explosive" = 0, "shock" = 0, "fire" = 0, "holy" = 0, "death" = 0}

var effects = {"bleed": Bleed.new()}

var held: int = 0

var tempEffects = {}

var tempDamage = {}

func resetTempEffects() -> void:
	tempEffects = {}

func addTempEffect(e:String, c:float) -> void:
	if tempEffects.find_key(e):
		tempEffects[e] += c
	else:
		tempEffects[e] = c

func resetTempDamage() -> void:
	tempDamage = {}
	
func addTempDamage(t:String, a:float) -> void:
	if tempDamage.find_key(t):
		tempDamage[t] += a
	else:
		tempDamage[t] = a

func addIEffect(t:String, e:String, c:float) -> void:
	if inherentEffects.find_key(t):
		var target: Dictionary = inherentEffects[t]
		if target.find_key(e):
			target[e] += c
		else:
			target[e] = c

func createNewProj(s: Sprite2D, pierce: bool, velo: Vector2, trail: bool, trailCol: Color, dT: String, d: int, effect: String, chance: float):
	var p: Projectile= preload("res://scenes/Projectiles/projectile.tscn").instantiate()
	p.setVars(s, pierce, velo, trail, trailCol)
	p.setType(dT)
	p.setDam(d)
	p.setEffect(effect)
	p.setChance(chance)
	return p
	
func createNewAOE(s: AnimatedSprite2D, d: Vector2, o: Vector2, dT: String, dam: int, effect: String, chance: float):
	var a: AOE = preload("res://scenes/Projectiles/aoe.tscn").instantiate()
	a.setVars(s, d, o)
	a.setType(dT)
	a.setDam(dam)
	a.setEffect(effect)
	a.setChance(chance)
	return a

func reset() -> void:
	enraged = 0
	weapons = [[],
	Weapon.new("Sword","slash",7,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true, Attribute.new(), Attribute.new()),
	Weapon.new("Great Sword","slash",10,2,Vector2(0,1),Vector2i(3,2),Vector2(0,0),true, Attribute.new(), Attribute.new()),
	Weapon.new("Mace","blunt",5,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), MaceMult.new()),
	Weapon.new("Spear","pierce",7,1,Vector2(0,1),Vector2i(1,3),Vector2(0,0),true, Attribute.new(), Attribute.new()),
	Weapon.new("Halberd","slash",5,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true, StanceChange.new(), Attribute.new()),
	Weapon.new("Stiletto","pierce",3,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), DexterityCheck.new())]

	damages = {"slash" = 0, "pierce" = 0, "blunt" = 0, "shockwave" = 0,
	"frost" = 0, "explosive" = 0, "shock" = 0, "fire" = 0, "holy" = 0}
	
	held = 0
	
	inherentEffects = {
		"slash": {},
		"pierce": {},
		"blunt": {},
		"shockwave": {},
		"frost": {},
		"explosive": {},
		"shock": {},
		"fire": {},
		"holy": {}
	}
	
	tempEffects = {}
	
	tempDamage = {}
	
