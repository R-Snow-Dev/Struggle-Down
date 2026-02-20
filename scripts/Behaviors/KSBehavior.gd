extends BossBehavior
class_name KSBehavior


func think() -> void:
	print("thinking")
	var t: Player = getTarget()
	var m: BossNew = getMyself()
	var f = m.getData().getFacing()
	print(f)
	if isPrepped():
		print("attacking")
		attack()
	else:
		getMyself().getData().setBump(false)
		findFacing()
		f = m.getData().getFacing()
		getMyself().getData().setActions(getMyself().getData().getActions()-1) # Decrease actions by 1
		print(Overseer.closestLOS(Vector2i(m.getPos()), Vector2i(f), Vector2i(0,1)), Overseer.closestByTarget("player", Vector2i(m.getPos())))
		if rng.randf() >= 0.75:
			print("summoning")
			setAttack(KingSummon.new(0, getMyself()))
			getAttack().warn()
			setPrepped(true)
		
		elif Overseer.closestLOS(Vector2i(m.getPos()), Vector2i(f), Vector2i(0,1)) == Overseer.closestByTarget("player", Vector2i(m.getPos())):
			print("charging")
			setAttack(KingSlide.new(1,getMyself()))
			getAttack().warn()
			setPrepped(true)
		else:
			getMyself().getData().setBump(true)
			print("jumping")
			setAttack(KingJump.new(1,getMyself()))
			getAttack().warn()
			setPrepped(true)
		getMyself().setDelay(0.2)

# Function that decides what direction to face, to always be facing the player
func findFacing():
	# Variables
	var t = getTarget()
	var m = getMyself()
	var mPos = m.getData().getPos()
	var tPos = t.getPos()
	
	
	var bestCase = tPos - mPos
	
	if abs(bestCase.x) >= abs(bestCase.y):
		m.getData().setFacing(Vector2(getSign(bestCase.x), 0))
	else:
		m.getData().setFacing(Vector2(0, getSign(bestCase.y)))	
	
func attack() -> void:
	setPrepped(false)
	getMyself().getData().setActions(getMyself().getData().getActions()-1) # Decrease actions by 1
	curAttack.attack()
	await EventBus.fiend_phase 
	EventBus.stop_warn.emit()
	
