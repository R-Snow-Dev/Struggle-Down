extends Node2D
class_name Fiend

"""
Super class for all Fiend data types
"""

# Variables
var data: FiendData
var effects: Array= []
var states: Array
var curState: String
var rng = RandomNumberGenerator.new()
var delay: float = 0
var pos: Vector2
var dPop = preload("res://scenes/GUIParts/damagePopup.tscn")
var paid = false
var magic = false
var bar: StatusBar = preload("res://scenes/DungeonParts/statusBar.tscn").instantiate()


# "set" and "get" functions for the variables
func setDelay(time:float) -> void:
	delay = time

func getDelay() -> float:
	return delay

func addEffect(e: Effect) -> void:
	if e not in effects:
		effects.append(e)
		bar.add(e)
		activateEffects(-1)

func getEffects() -> Array:
	return effects

func activateEffects(n: int):
	for x:Effect in getEffects():
		if x.getEffectTime() == n:
			x.activate(self)

func resetEffects() -> void:
	activateEffects(0)
	effects = []
	bar.reset()

func setData(p: Vector2, h: int, a: int, gR: Vector2, d: int, f: Vector2, b: RefCounted, dT: Array = [], m: Dictionary = {}) -> void:
	data = FiendData.new(p, h, a, gR, d, f, b, dT, m)
	bar.scale = Vector2(0.25,0.25)
	add_child(bar)
	

func setStates(s: Array) -> void:
	states = s
	
func setCurState(s: String) -> void:
	curState = s
	
func setPos(p: Vector2) -> void:
	getData().setPos(p)
	
func getData() -> FiendData:
	return data

func updateHealth(n: int) -> void:
	var num = n * WeaponList.mult
	var popup:DamagePopup = dPop.instantiate()
	if num < 0:
		AudioManager.play_sound('EnemyDamaged')
	popup.setup(num)
	add_child(popup)
	getData().updateHealth(num)

func getPos() -> Vector2:
	return getData().getPos()
	
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
	var dt = getData().dropTable
	if getData().getHealth() < 1:
		for x:Attribute in UpgradeList.getByType("onKill"):
			x.effect(self)
		for x in range(0,UpgradeList.relicData['dropAttempts']):
			if rng.randf() > 0.25:
				if len(dt) > 0:
					SaveController.addComponent(getData().dt[rng.randi_range(0, len(dt) - 1)])
		return true
	return false

# Functions to be overridden by the child classes
func chooseState() -> void:
	pass
	
func move(_grid: gameBoard, _target: Player) -> void:
	pass

func calc(num: int, type: String, i:bool):
	var ms = getData().modifiers
	var total = num
	total += WeaponList.damages[type]
	if type == 'death' and !(ms.has(type)):
		return 999
	if ms.has(type) and !i:
		return total * ms[type]
	return total

func addEffects(w: Weapon):
	var chances = w.getChances()
	var dTypes = w.getExtraAttacks().duplicate()
	dTypes.append(w.getDamageType())
	for k in chances:
		if rng.randf() <= w.getChance(k) + WeaponList.flatChance:
			addEffect(WeaponList.effects[k])
	for t in dTypes:
		var target = WeaponList.inherentEffects[t]
		for k in target:
			if rng.randf() <= target[k] + WeaponList.flatChance:
				addEffect(WeaponList.effects[k])
			
func checkTemps( ) -> int:
	var total = 0
	var tempD = WeaponList.tempDamage
	var tempE = WeaponList.tempEffects
	for d in tempD:
		total += calc(tempD[d], d, false)
	for e in tempE:
		if rng.randf() <= tempE[e] + WeaponList.flatChance:
			addEffect(WeaponList.effects[e])
	return total

func calcWeaponEffect(e: WeaponEffect) -> int:
	var total = 0
	total += calc(e.getDam(), e.getType(), false)
	if e.getEffect():
		if rng.randf() <= e.getChance() + WeaponList.flatChance:
			addEffect(WeaponList.effects[e.getEffect()])
	if UpgradeList.relicData['goldMult']:
		total *= 0.01 * Overseer.getGold()
	if UpgradeList.relicData['spark'] and Overseer.getWrath():
		total *= 2
	return total

func calcWild(w: WildDamage):
	var total = 0
	total += calc(w.getDam(), w.getType(), false)
	if w.getEffect():
		if rng.randf() <= w.getChance() + WeaponList.flatChance:
			addEffect(WeaponList.effects[w.getEffect()])
	return total

func calcDamage(w: Weapon):
	var total = calc(w.getAtkDam(), w.getDamageType(), w.getIgnore())
	for x in w.getExtraAttacks():
		total += calc(0, x, w.getIgnore())
	for x:Attribute in UpgradeList.getByType("onHit"):
		total += calc(x.effect(self), x.damageType, w.getIgnore())
	total += checkTemps()
	addEffects(w)
	
	for x in UpgradeList.getByType('hitMult'):
		total *= x.effect(self)
	
	if WeaponList.held < 7:
		total = total * (1 + (0.25 * WeaponList.enraged)) * UpgradeList.relicData['meleeMult']
	else:
		total = total * (1 + (0.25 * WeaponList.enraged)) * UpgradeList.relicData['magMult']
	if UpgradeList.relicData['goldMult']:
		total *= 0.01 * Overseer.getGold()
	if UpgradeList.relicData['spark'] and Overseer.getWrath():
		total *= 2
	return total

func onHit(area: Area2D) -> void:
	# Function that either damages the player, or deals damage to itself depending
	# on what it collides with
	if area is Player:
		EventBus.update_hp.emit(-getData().getDam())
		for x: Attribute in UpgradeList.getByType("onAttacked"):
			x.effect(self)
	elif area is Hurtbox:
		updateHealth(-calcDamage(area.getWeaponData()))
	elif area is WeaponEffect:
		updateHealth(-calcWeaponEffect(area)) 
	elif area is WildDamage:
		updateHealth(-calcWild(area))
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
	
		
func reset():
	pass
