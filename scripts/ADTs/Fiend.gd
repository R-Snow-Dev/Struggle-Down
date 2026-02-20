extends Node2D
class_name Fiend

"""
Super class for all Fiend data types
"""

# Variables
var data: FiendData
var effects: Array= []
var modifiers: Dictionary = {}
var states: Array
var curState: String
var rng = RandomNumberGenerator.new()
var delay: float = 0
var pos: Vector2

func _ready() -> void:
	EventBus.summon.connect(summon)

# "set" and "get" functions for the variables
func setDelay(time:float) -> void:
	delay = time

func getDelay() -> float:
	return delay

func addEffect(e: Effect) -> void:
	if e not in effects:
		effects.append(e)

func getEffects() -> Array:
	return effects

func activateEffects(n: int):
	for x:Effect in getEffects():
		if x.getEffectTime() == n:
			x.activate(self)

func setData(p: Vector2, h: int, a: int, gR: Vector2, d: int, f: Vector2, b: RefCounted) -> void:
	data = FiendData.new(p, h, a, gR, d, f, b)

func setStates(s: Array) -> void:
	states = s
	
func setCurState(s: String) -> void:
	curState = s
	
func setPos(p: Vector2) -> void:
	pos = p	
	
func getData() -> FiendData:
	return data

func getPos() -> Vector2:
	return pos

func getStates() -> Array:
	return states
	
func getCurState() -> String:
	return curState

func myName() -> String:
	return "fiend"

# Resets the available actions of the Fiend to the max amount
func restoreActions():
	getData().restoreActions()

# Checks to see if the Fiend's hp is less than 1
func isDead() -> bool:
	if getData().getHealth() < 1:
		for x:Attribute in UpgradeList.getByType("onKill"):
			x.effect(self)
		return true
	return false

# Functions to be overridden by the child classes
func chooseState() -> void:
	pass
	
func move(_grid: gameBoard, _target: Player) -> void:
	pass

func calc(num: int, type: String, i:bool):
	if modifiers.has(type) and !i:
		return num * modifiers[type]
	return num

func addEffects(w: Weapon):
	var chances = w.getChances()
	var dTypes = w.getExtraAttacks().duplicate()
	dTypes.append(w.getDamageType())
	for k in chances:
		if rng.randf() <= w.getChance(k):
			addEffect(WeaponList.effects[k])
	for t in dTypes:
		var target = WeaponList.inherentEffects[t]
		for k in target:
			if rng.randf() <= target[k]:
				addEffect(WeaponList.effects[k])
			
func checkTemps( ) -> int:
	var total = 0
	var tempD = WeaponList.tempDamage
	var tempE = WeaponList.tempEffects
	for d in tempD:
		total += calc(tempD[d], d, false)
	for e in tempE:
		if rng.randf() <= tempE[e]:
			addEffect(WeaponList.effects[e])
	return total

func calcWeaponEffect(e: WeaponEffect) -> int:
	var total = 0
	total += calc(e.getDam(), e.getType(), false)
	if e.getEffect():
		if rng.randf() <= e.getChance():
			addEffect(WeaponList.effects[e.getEffect()])
	return total

func calcDamage(w: Weapon):
	var total = calc(w.getAtkDam(), w.getDamageType(), w.getIgnore())
	total += calc(WeaponList.damages[w.getDamageType()], w.getDamageType(), w.getIgnore())
	for x in w.getExtraAttacks():
		total += calc(WeaponList.damages[x], x, w.getIgnore())
		print(w.getExtraAttacks())
	for x:Attribute in UpgradeList.getByType("onHit"):
		total += calc(x.effect(self), x.damageType, w.getIgnore())
	total += checkTemps()
	addEffects(w)
	return total

func onHit(area: Area2D) -> void:
	# Function that either damages the player, or deals damage to itself depending
	# on what it collides with
	if area is Player:
		EventBus.update_hp.emit(-getData().getDam())
	elif area is Hurtbox:
		getData().updateHealth(-calcDamage(area.getWeaponData()))
	elif area is WeaponEffect:
		getData().updateHealth(-calcWeaponEffect(area)) 
	elif area is WildDamage:
		getData().updateHealth(-calc(area.getDam(), area.getType(), false))
	elif area is EatBox:
		getData().updateHealth(-999)
		EventBus.healSK.emit()
	for x in UpgradeList.getByType("active"):
		if x is Brand:
			x.store(area)

# Draws the Fiend to the game board
func draw() -> void:
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = getData().getPos().x*16
	position.y =getData().getPos().y*16 - 4
	self.z_index = (getData().getPos().y + 1)
	
func summon(target: Node, e: PackedScene, d: int, t: String):
	if target == self:
		var entity = e.instantiate()
		entity.setDam(d)
		entity.setType(t)
		entity.position = global_position
		get_parent().add_child(entity)
