extends Node
class_name Armory

var weapons = [[],
	Weapon.new("Sword","slash",7,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true, Attribute.new(), Attribute.new(), LakeSword.new(), BranchSword.new()),
	Weapon.new("Great Sword","slash",10,2,Vector2(0,1),Vector2i(3,2),Vector2(0,0),true, Attribute.new(), Attribute.new(), MoonGS.new(), BlackGS.new()),
	Weapon.new("Mace","blunt",5,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), MaceMult.new(), TrollMace.new(), MeteorMace.new()),
	Weapon.new("Spear","pierce",7,1,Vector2(0,1),Vector2i(1,3),Vector2(0,0),true, Attribute.new(), Attribute.new(), LSpear.new(), DemonSpear.new()),
	Weapon.new("Halberd","slash",5,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true, StanceChange.new(), Attribute.new(), NancyHalberd.new(), KingHalberd.new()),
	Weapon.new("Stiletto","pierce",3,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), DexterityCheck.new(), BetrayStiletto.new(), RegalStiletto.new()),
	Weapon.new("Ice Wand","frost",5,1,Vector2(0,1),Vector2i(1,1),Vector2(0,175),false, Attribute.new(), Attribute.new(), Neptune.new(), BlackIce.new()), 
	Weapon.new("Quake Staff","shockwave",1,1,Vector2(0,-25),Vector2i(50,50),Vector2(0,0),true, Attribute.new(), Attribute.new(), Wrath.new(), Richter.new()),
	Weapon.new("Unstable Wand","fire",3,2,Vector2(0,1),Vector2i(1,1),Vector2(0,175),false, Attribute.new(), Attribute.new(), Tyrant.new(), Elder.new()),
	Weapon.new("Thunder Gem","shock",4,1,Vector2(0,1),Vector2i(1,11),Vector2(0,0),true, Attribute.new(), Attribute.new(), Olympus.new(), Refined.new()),
	Weapon.new("Wind Charm","slash",3,1,Vector2(0,-1),Vector2i(3,3),Vector2(0,0),true, Attribute.new(), Attribute.new(), Spring.new(), Artisan.new()),
	Weapon.new("Demon Horn","fire",2,1,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), PlaceFire.new(), AstarothHorn.new(), InfernalHorn.new()),
	Weapon.new("Holy Scepter","holy",5,1,Vector2(0,1),Vector2i(0,0),Vector2(0,0),true, Attribute.new(), HandOfGod.new(), Prophet.new(), Peter.new()),]

var titles = [[],
['Sword','Sword of thge Lake','Seven Branched Sword'],
['Great Sword','Great Sword of the Moon', "Black Knight's Great Sword"],
['Mace', 'Mace of the Troll', 'Meteoric Mace'],
['Spear','Spear of Longinus', "Demon's Spear"],
['Halberd', 'Halberd of Nancy', 'Kingsoul Halberd'],
['Stiletto','Stiletto of the Betrayer', 'Regal Stiletto'],
['Ice Wand','Ice Wand of Neptune','Black Ice Wand'],
['Quake Staff','Quake Staff of Wrath', "Richter's Quake Staff"],
['Unstable Wand', 'Unstable Wand of the Tyrant', 'Elder Unstable Wand'],
['Thunder Gem', 'Thunder Gem of Olympus', 'Refined Thunder Gem'],
['Wind Charm', 'Wind Charm of Spring', 'Artisan Wind Charm'],
['Demon Horn', 'Demon Horn of Astaroth', 'Infernal Demon Horn'],
['Holy Scepter', 'Holy Scepter of the Prophet', "Peter's Holy Scepter"]]

var inherentEffects = {
	"slash": {},
	"pierce": {},
	"blunt": {},
	"shockwave": {},
	"frost": {},
	"explosive": {},
	"shock": {'stun': 0.05},
	"fire": {},
	"holy": {}
}

var mult = 0.75

var flatChance = 0

var enraged: int = 0

var damages = {"slash": 0, "pierce": 0, "blunt": 0, "shockwave": 0,
"frost": 0, "explosive": 0, "shock": 0, "fire": 0, "holy": 0, "death": 0}

var effects = {"bleed": Bleed.new(),
				'slow': Slow.new(),
				'stun': Stun.new(),
				'burn': Burn.new(),
				'blackfrost': BlackFrost.new(),
				'exchain': ExChain.new()}

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
	Weapon.new("Sword","slash",7,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true, Attribute.new(), Attribute.new(), LakeSword.new(), BranchSword.new()),
	Weapon.new("Great Sword","slash",10,2,Vector2(0,1),Vector2i(3,2),Vector2(0,0),true, Attribute.new(), Attribute.new(), MoonGS.new(), BlackGS.new()),
	Weapon.new("Mace","blunt",5,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), MaceMult.new(), TrollMace.new(), MeteorMace.new()),
	Weapon.new("Spear","pierce",7,1,Vector2(0,1),Vector2i(1,3),Vector2(0,0),true, Attribute.new(), Attribute.new(), LSpear.new(), DemonSpear.new()),
	Weapon.new("Halberd","slash",5,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true, StanceChange.new(), Attribute.new(), NancyHalberd.new(), KingHalberd.new()),
	Weapon.new("Stiletto","pierce",3,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), DexterityCheck.new(), BetrayStiletto.new(), RegalStiletto.new()),
	Weapon.new("Ice Wand","frost",5,1,Vector2(0,1),Vector2i(1,1),Vector2(0,175),false, Attribute.new(), Attribute.new(), Neptune.new(), BlackIce.new()), 
	Weapon.new("Quake Staff","shockwave",1,1,Vector2(0,-25),Vector2i(50,50),Vector2(0,0),true, Attribute.new(), Attribute.new(), Wrath.new(), Richter.new()),
	Weapon.new("Unstable Wand","fire",3,2,Vector2(0,1),Vector2i(1,1),Vector2(0,175),false, Attribute.new(), Attribute.new(), Tyrant.new(), Elder.new()),
	Weapon.new("Thunder Gem","shock",4,1,Vector2(0,1),Vector2i(1,11),Vector2(0,0),true, Attribute.new(), Attribute.new(), Olympus.new(), Refined.new()),
	Weapon.new("Wind Charm","slash",3,1,Vector2(0,-1),Vector2i(3,3),Vector2(0,0),true, Attribute.new(), Attribute.new(), Spring.new(), Artisan.new()),
	Weapon.new("Demon Horn","fire",2,1,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true, Attribute.new(), PlaceFire.new(), AstarothHorn.new(), InfernalHorn.new()),
	Weapon.new("Holy Scepter","holy",5,1,Vector2(0,1),Vector2i(0,0),Vector2(0,0),true, Attribute.new(), HandOfGod.new(), Prophet.new(), Peter.new()),]

	damages = {"none" : 0, "slash" : 0, "pierce" : 0, "blunt" : 0, "shockwave" : 0,
	"frost" : 0, "explosive" : 0, "shock" : 0, "fire" : 0, "holy" : 0}
	
	held = 0
	
	inherentEffects = {
		"none": {},
		"slash": {},
		"pierce": {},
		"blunt": {},
		"shockwave": {},
		"frost": {},
		"explosive": {},
		"shock": {'stun': 0.05},
		"fire": {},
		"holy": {}
	}
	
	tempEffects = {}
	
	tempDamage = {}
	
