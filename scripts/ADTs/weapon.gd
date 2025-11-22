extends RefCounted
class_name Weapon

"""
Parent ADT that represents a weapon in game
"""

var name: String
var damageType: String # Damage type of the weapon
var BaseDamage: int # Base damage of the weapon
var cost: int # Action cost of the weapon
var origin: Vector2 # Where the attack will spawn
var dimensions: Vector2i # the size of the attack
var velocity: Vector2 # How fast the attack will move
var piercing: bool = false # If the attack goes through walls and enemies
var extraAttacks: Array = []
var effectChances: Dictionary = {"bleeding" = 0}
var attribute: Attribute

func _init(n: String, d: String, b: int, c: int, o: Vector2, dim: Vector2i, v: Vector2, p: bool) -> void:
	name = n
	damageType = d
	BaseDamage = b
	cost = c
	origin = o
	dimensions = dim
	velocity = v
	piercing = p

func setAttribute(a: Attribute) -> void:
	attribute = a
	
func getChance(effect: String) -> float:
	return effectChances[effect]	

func getExtraAttacks() -> Array:
	return extraAttacks	
	
func getName() -> String:
	return name	
	
func getDamageType() -> String:
	return damageType
	
func getBaseDam() -> float:
	return BaseDamage
	
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
	effectChances[effect] += num

func setDamageType(data: String) -> void:
	damageType = data

func setBaseDam(data: int) -> void:
	BaseDamage = data

func addBaseDam(data:int) -> void:
	BaseDamage += data

func addExtraAttack(a: String) -> void:
	if a not in extraAttacks:
		extraAttacks.append(a)

func setCost(data:int) -> void:
	cost = data

func setOrigin(data: Vector2) -> void:
	origin = data

func setDim(data: Vector2i) -> void:
	dimensions = data
	
func setVelo(data: Vector2) -> void:
	velocity = data
	
func setPierce(data: bool) -> void:
	piercing = data

func sacrifice() -> void:
	UpgradeList.addAttribute(attribute)

func onSpecial(_data) -> void:
	pass

func onAttack(_data) -> void:
	pass
	
