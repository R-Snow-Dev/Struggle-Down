extends Fiend
class_name BossNew

var hitbox: Area2D

func myName() -> String:
	return "boss"

func setHbox(area: Area2D) -> void:
	hitbox = area

func setData(p: Vector2, h: int, a: int, gR: Vector2, d: int, f: Vector2, b: RefCounted) -> void:
	pass

func setBossData(p: Vector2, h: int, a: int, gR: Vector2, d: int, f: Vector2, b: RefCounted, s:int) -> void:
	data = BossData.new(p, h, a, gR, d, f, b,s)

func positionToPos():
	var size = getData().getSize()
	# Converts on-screen position to internal position
	var newP = position - Vector2(size*4,size*4 - 4)
	newP = newP / 16
	getData().setPos(newP)
	draw()

func onHit(area: Area2D) -> void:
	# Function that either damages the player, or deals damage to itself depending
	# on what it collides with
	if area is Player:
		EventBus.update_hp.emit(-getData().getDam())
		if getData().getBump():
			EventBus.bump.emit()
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

func draw() -> void:
	# Function that takes the pos variable of the boss and converts it into
	# on-screen coordinates
	var size = getData().getSize()
	position.x = getData().getPos().x*16 + size*4
	position.y = getData().getPos().y*16 + (size*4 - 4)
	self.z_index = (getData().getPos().y + 1)

func toggleHbox() -> void:
	hitbox.monitoring = !hitbox.monitoring
