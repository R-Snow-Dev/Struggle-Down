extends Node2D

"""
Updated script that handles when an player attacks. Spawns the AOE visuals 
when a weapon is hovered, and spawns a correctly sized hurtbox when the weapon 
is clicked.
"""

@onready var aP = $Attack
# Other variables
var reticle = preload("res://scenes/GUIParts/AreaOfEffect.tscn")
var dist = 0
var gridSize = Vector2(0,0)
var ID: int = 0

# Connects signals to correct functions	
func _ready() -> void:
	EventBus.attack.connect(attack)
	EventBus.spWeapon.connect(special)
	EventBus.updateAOE.connect(updateAOE)
	EventBus.hoverProj.connect(hoverProj)
	EventBus.offHover.connect(offHover)

# Sets gridSize to the given Vector2
func setGrid(data: Vector2) -> void:
	gridSize = data

# Update the AoE effects when the updateAOE signal is triggered
func updateAOE(id: int):
	offHover()
	if id > 0:
		ID = id
		hover(id)                                  	

# Deletes all old AoE effects
func offHover():
	for c in get_children():
		if c is AreaOfEffect:
			remove_child(c)
			c.queue_free()	

func hoverProj(p: Projectile):
	var dir: Vector2
	var player = get_parent()
	var center = Vector2(0,0)
	var dim = Vector2(1,1)
	var range = Vector2((dim.x-1)/2, dim.y)
	var pos: Vector2
	var mins: Vector2
	var maxs: Vector2
	dist = 0
	gridSize = Overseer.control.gridSize
	print(gridSize)
	
	if player.facing.x + player.facing.y < 1:
		if player.facing.x != 0:
			maxs = Vector2((gridSize.y * abs(player.facing.x) - player.pos.y-1), (gridSize.x * abs(player.facing.y) - player.pos.x) * -1)
			mins = Vector2((gridSize.y * abs(player.facing.y) - player.pos.y), (gridSize.x * abs(player.facing.x) - player.pos.x) * -1)
		else:
			maxs = Vector2((gridSize.x * abs(player.facing.y) - player.pos.x-1), (gridSize.y * abs(player.facing.y) - player.pos.y)-1)
			mins = Vector2((gridSize.x * abs(player.facing.x) - player.pos.x), (gridSize.y * abs(player.facing.x) - player.pos.y))
			
	else:
		if player.facing.x != 0:
			maxs = Vector2((gridSize.y * abs(player.facing.y) - player.pos.y) * -1, (gridSize.x * abs(player.facing.x) - player.pos.x-1))
			mins = Vector2((gridSize.y * abs(player.facing.x) - player.pos.y-1) * -1, (gridSize.x * abs(player.facing.y) - player.pos.x))
		else:
			maxs = Vector2((gridSize.x * abs(player.facing.x) - player.pos.x) * -1, (gridSize.y * abs(player.facing.x) - player.pos.y)*-1)
			mins = Vector2((gridSize.x * abs(player.facing.y) - player.pos.x-1) * -1, (gridSize.y * abs(player.facing.y) - player.pos.y)*-1)

	for x in range(range.x*-1, range.x + 1):
		for y in range(0, range.y):
			if p.velo.x != 0 or p.velo.y != 0:
				pos = Vector2(x, y) + center
				while pos.x <= maxs.x and pos.x >= mins.x and pos.y <= maxs.y and pos.y >= mins.y:
					var r = reticle.instantiate()
					r.position = pos * 16
					add_child(r)
					var distV = abs(pos*center)
					dist = sqrt(pow(distV.x,2) + pow(distV.y,2))
					var v = p.velo
					pos += Vector2(1 * getSign(v.x), 1 * getSign(v.y))
			else:
				pos = center + Vector2(x, y)
				if pos.x <= maxs.x and pos.x >= mins.x and pos.y <= maxs.y and pos.y >= mins.y:
					var r = reticle.instantiate()
					r.position = pos * 16
					add_child(r)

# Calculates the positions of each AoE effect based on the dimensions of
# the attack and it's velocity
func hover(id: int):
	var dir: Vector2
	var player = get_parent()
	var w: Weapon = WeaponList.weapons[id]
	var center = w.getOrigin()
	var dim = w.getDim()
	var range = Vector2((dim.x-1)/2, dim.y)
	var pos: Vector2
	var mins: Vector2
	var maxs: Vector2
	dist = 0
	gridSize = Overseer.control.gridSize
	print(gridSize)
	
	if player.facing.x + player.facing.y < 1:
		if player.facing.x != 0:
			maxs = Vector2((gridSize.y * abs(player.facing.x) - player.pos.y-1), (gridSize.x * abs(player.facing.y) - player.pos.x) * -1)
			mins = Vector2((gridSize.y * abs(player.facing.y) - player.pos.y), (gridSize.x * abs(player.facing.x) - player.pos.x) * -1)
		else:
			maxs = Vector2((gridSize.x * abs(player.facing.y) - player.pos.x-1), (gridSize.y * abs(player.facing.y) - player.pos.y)-1)
			mins = Vector2((gridSize.x * abs(player.facing.x) - player.pos.x), (gridSize.y * abs(player.facing.x) - player.pos.y))
			
	else:
		if player.facing.x != 0:
			maxs = Vector2((gridSize.y * abs(player.facing.y) - player.pos.y) * -1, (gridSize.x * abs(player.facing.x) - player.pos.x-1))
			mins = Vector2((gridSize.y * abs(player.facing.x) - player.pos.y-1) * -1, (gridSize.x * abs(player.facing.y) - player.pos.x))
		else:
			maxs = Vector2((gridSize.x * abs(player.facing.x) - player.pos.x) * -1, (gridSize.y * abs(player.facing.x) - player.pos.y)*-1)
			mins = Vector2((gridSize.x * abs(player.facing.y) - player.pos.x-1) * -1, (gridSize.y * abs(player.facing.y) - player.pos.y)*-1)

	for x in range(range.x*-1, range.x + 1):
		for y in range(0, range.y):
			if w.getVelo().x != 0 or w.getVelo().y != 0:
				pos = Vector2(x, y) + center
				while pos.x <= maxs.x and pos.x >= mins.x and pos.y <= maxs.y and pos.y >= mins.y:
					var r = reticle.instantiate()
					r.position = pos * 16
					add_child(r)
					var distV = abs(pos*center)
					dist = sqrt(pow(distV.x,2) + pow(distV.y,2))
					var v = w.getVelo()
					pos += Vector2(1 * getSign(v.x), 1 * getSign(v.y))
			else:
				pos = center + Vector2(x, y)
				if pos.x <= maxs.x and pos.x >= mins.x and pos.y <= maxs.y and pos.y >= mins.y:
					var r = reticle.instantiate()
					r.position = pos * 16
					add_child(r)

func getSign(num:int) -> int:
	if num > 0:
		return 1
	elif num < 0:
		return -1
	return 0
	
# Creates a hurtbox based on weapon data. No action cost.
func freeAttack(id: int):
	hover(id)
	var hurtbox: Hurtbox = preload("res://scenes/DungeonParts/hurtbox.tscn").instantiate()
	var lf = 0.1
	var projectiles: Array = [
	preload("res://scenes/Projectiles/Sprites/ice.tscn"),
	preload("res://scenes/Projectiles/Sprites/fire.tscn"),
	preload("res://scenes/Projectiles/Sprites/lightning.tscn"),
	preload("res://scenes/Projectiles/Sprites/quake.tscn"),
	preload("res://scenes/Projectiles/Sprites/wind.tscn"),
	]
	var pindex: int = -1
	if id > 0:
		var player:Player = get_parent()
		var w: Weapon = WeaponList.weapons[id]
		print(str(id))
		print(str(WeaponList.held))
		w.setFacing(player.facing)
		EventBus.pause.emit()
		aP.position = w.getOrigin() * 16
		if w.getDamageType() == "slash":
			if id != 11:
				aP.slash(w.getDim())
			else:
				pindex = 4
				lf = 0.5
		elif w.getDamageType() == "pierce":
			aP.pierce(w.getDim())
		elif w.getDamageType() == 'frost':
			pindex = 0
		elif w.getDamageType() == 'fire':
			pindex = 1
		elif w.getDamageType() == 'shockwave':
			lf = 1
			pindex = 3
		elif w.getDamageType() == 'shock':
			pindex = 2
			lf = 0.4
		if w.getDamageType() == 'slash' or w.getDamageType() == 'pierce' or w.getDamageType() == 'blunt':
			AudioManager.play_sound('Melee')
		w.onAttack(player)
		if id == 13:
			await w.attackAttribute.effectDone
		if w.getVelo() == Vector2(0,0):
			for c in get_children():
				if c is AreaOfEffect:
					var e: AttackEffects = preload("res://scenes/GUIParts/effect.tscn").instantiate()
					if pindex >= 0:
						e.setSprite(projectiles[pindex].instantiate())
					e.setLifespan(lf)
					c.add_child(e)
		else:
			if pindex >= 0:
				hurtbox.setSprite(projectiles[pindex].instantiate())
		hurtbox.setup(w, dist)
		hurtbox.setLifespan(lf)
		add_child(hurtbox)
	else:
		EventBus.playerDoneAttacking.emit()
	
# Creates a hurtbox based on weapon data.
func attack(id: int):
	var hurtbox: Hurtbox = preload("res://scenes/DungeonParts/hurtbox.tscn").instantiate()
	var lf = 0.1
	var projectiles: Array = [
	preload("res://scenes/Projectiles/Sprites/ice.tscn"),
	preload("res://scenes/Projectiles/Sprites/fire.tscn"),
	preload("res://scenes/Projectiles/Sprites/lightning.tscn"),
	preload("res://scenes/Projectiles/Sprites/quake.tscn"),
	preload("res://scenes/Projectiles/Sprites/wind.tscn"),
	]
	var pindex: int = -1
	if id > 0:
		var player:Player = get_parent()
		var w: Weapon = WeaponList.weapons[id]
		w.setFacing(player.facing)
		if player.actionsAvailable >= w.getCost():
			print(w.getCost())
			EventBus.pause.emit()
			aP.position = w.getOrigin() * 16
			if w.getDamageType() == "slash":
				if id != 11:
					aP.slash(w.getDim())
				else:
					pindex = 4
					lf = 0.5
			elif w.getDamageType() == "pierce":
				aP.pierce(w.getDim())
			elif w.getDamageType() == 'frost':
				pindex = 0
			elif w.getDamageType() == 'fire':
				pindex = 1
			elif w.getDamageType() == 'shockwave':
				lf = 1
				pindex = 3
			elif w.getDamageType() == 'shock':
				pindex = 2
				lf = 0.4
			if w.getDamageType() == 'slash' or w.getDamageType() == 'pierce' or w.getDamageType() == 'blunt':
				AudioManager.play_sound('Melee')
			w.onAttack(player)
			if id == 13:
				await w.attackAttribute.effectDone
			if w.getVelo() == Vector2(0,0):
				for c in get_children():
					if c is AreaOfEffect:
						var e: AttackEffects = preload("res://scenes/GUIParts/effect.tscn").instantiate()
						if pindex >= 0:
							e.setSprite(projectiles[pindex].instantiate())
						e.setLifespan(lf)
						c.add_child(e)
			else:
				if pindex >= 0:
					hurtbox.setSprite(projectiles[pindex].instantiate())
			hurtbox.setup(w, dist)
			hurtbox.setLifespan(lf)
			add_child(hurtbox)
			EventBus.updateActions.emit(w.getCost() * -1, "attack")
			w.check()
		else:
			print(w.getCost())
			w.check()
			print("Not Enough Actions")
			EventBus.playerDoneAttacking.emit()
	else:
		EventBus.playerDoneAttacking.emit()

# Athunder_gem_itemctivates a weapon's special function on a right click		
func special(id: int):
	var player = get_parent()
	if id > 0:
		var weapon: Weapon = WeaponList.weapons[id]
		weapon.onSpecial(player)
		offHover()
		hover(id)
