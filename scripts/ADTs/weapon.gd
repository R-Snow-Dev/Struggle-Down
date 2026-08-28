extends RefCounted
class_name Weapon

"""
Parent ADT that represents a weapon in game
"""

var name: String
var damageType: String # Damage type of the weapon
var BaseDamage: int # Base damage of the weapon
var curDamage: int
var cost: int # Action cost of the weapon
var origin: Vector2 # Where the attack will spawn
var dimensions: Vector2i # the size of the attack
var velocity: Vector2 # How fast the attack will move
var piercing: bool = false # If the attack goes through walls and enemies
var extraAttacks: Array = []
var effectChances: Dictionary = {}
var attribute: Attribute
var ignore: bool = false
var specialAttribute: Attribute
var attackAttribute: Attribute
var facing: Vector2i = Vector2i(0,-1)
var tMod = 0
var tAttribute1: Attribute
var tAttribute2: Attribute
var p: int
var pd: Vector2i
var po: Vector2
var pdam: int

func _init(n: String, d: String, b: int, c: int, o: Vector2, dim: Vector2i, v: Vector2, p: bool, sA:Attribute, aA:Attribute, t1:Attribute, t2:Attribute) -> void:
	name = n
	damageType = d
	BaseDamage = b
	curDamage = b
	velocity = v
	piercing = p
	specialAttribute = sA
	attackAttribute = aA
	tAttribute1 = t1
	tAttribute2 = t2
	setCost(c)
	setDim(dim)
	setOrigin(o)

func setFacing(v: Vector2i) -> void:
	facing = v

func setIgnore(b:bool) -> void:
	ignore = b

func setAttribute(a: Attribute) -> void:
	attribute = a
	
func setTMod(a: int) -> void:
	tMod = a

func getTMod() -> int:
	return tMod

func getFacing() -> Vector2i:
	return facing

func getIgnore() -> bool:
	return ignore

func getChance(effect: String) -> float:
	return effectChances[effect]	
	
func getChances() -> Dictionary:
	return effectChances

func getExtraAttacks() -> Array:
	return extraAttacks	
	
func getName() -> String:
	return name	
	
func getDamageType() -> String:
	return damageType
	
func getBaseDam() -> float:
	return BaseDamage
	
func getAtkDam() -> int:
	return curDamage
	
func getCost() -> int:
	return cost

func getOrigin() -> Vector2:
	return origin
	
func getDim() -> Vector2i:
	return dimensions
	
func getVelo() -> Vector2:
	return velocity
	
func getPiercing() -> bool:
	return piercing

func addChance(effect: String, num: float) -> void:
	if effectChances.find_key(effect):
		effectChances[effect] += num
	else:
		effectChances[effect] = num

func setChance(effect: String, num: float) -> void:
	if effectChances.find_key(effect):
		effectChances[effect] += num

func setDamageType(data: String) -> void:
	damageType = data

func setBaseDam(data: int) -> void:
	BaseDamage = data
	curDamage = getBaseDam()
	
func setAtkDam(data: int) -> void:
	curDamage = data

func addBaseDam(data:int) -> void:
	BaseDamage += data
	curDamage = getBaseDam()

func addExtraAttack(a: String) -> void:
	if a not in extraAttacks:
		extraAttacks.append(a)

func setCost(data:int) -> void:
	cost = data
	p = data

func setTCost(data: int) -> void:
	cost = data

func addCost(data: int) -> void:
	cost += data

func setOrigin(data: Vector2) -> void:
	origin = data
	po = data

func setTOrigin(data: Vector2) -> void:
	origin = data

func setAtkAttribute(a: Attribute) -> void:
	attackAttribute = a

func setSpeAttribute(a: Attribute) -> void:
	specialAttribute = a

func setDim(data: Vector2i) -> void:
	dimensions = data
	pd = data

func setTDim(data: Vector2i) -> void:
	dimensions = data

func setVelo(data: Vector2) -> void:
	velocity = data
	
func setPierce(data: bool) -> void:
	piercing = data

func sacrifice() -> void:
	UpgradeList.addAttribute(attribute)

func check() -> void:
	setCost(p)
	setDim(pd)
	setOrigin(po)
	
func onSpecial(data) -> void:
	if getTMod() == 1:
		tAttribute1.special(data)
	elif getTMod() == 2:
		tAttribute2.special(data)
	specialAttribute.special(data)

func onAttack(data) -> void:
	if getTMod() == 1:
		tAttribute1.effect(data)
	elif getTMod() == 2:
		tAttribute2.effect(data)
	attackAttribute.effect(data)
	
