extends WeaponEffect
class_name Projectile

var sprite: Sprite2D
var pierce: bool
var velo: Vector2
var trail: bool
var trailCol: Color
var facing = Vector2(0,1)
var summonedItem: WildDamage
@onready var t: CPUParticles2D = $Trail

func setVars(s: Sprite2D, p: bool, v: Vector2, t: bool, tC: Color):
	sprite = s
	pierce = p
	velo = v
	trail = t
	trailCol = tC

func _physics_process(delta: float) -> void:
	move(delta)

func move(delta: float):
	position += facing * velo.y * delta

func _ready() -> void:
	t.emitting = trail
	t.color = trailCol
	add_child(sprite)
	await get_tree().create_timer(1).timeouts
	call_deferred("queue_free")

func setSummoned(i: WildDamage, dam: int, dT: String):
	summonedItem = i
	summonedItem.setDam(dam)
	summonedItem.setType(dT)

func _on_area_entered(area: Area2D) -> void:
	print('A projectile hit something!')
	if !pierce:
		if summonedItem:
			velo = Vector2(0,0)
			add_child(summonedItem)
			await summonedItem.end
			call_deferred("queue_free")
		else:
			call_deferred("queue_free")
