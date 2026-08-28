extends ItemEffect
class_name FireScrollEffect

var explode = preload("res://scenes/DungeonParts/explosion.tscn").instantiate()
var mag: int
var s = preload("res://scenes/Projectiles/Sprites/fire.tscn").instantiate()
var j: Projectile

func _init(m: int) -> void:
	mag = m
	j = WeaponList.createNewProj(s, false, Vector2(0,200), true, Color(255,255,255,0.5), 'fire', 1 + mag, 'none', 0)
	j.setSummoned(explode, 2+mag, 'explosive')
	
func hover():
	EventBus.hoverProj.emit(j)
	
func offHover():
	EventBus.offHover.emit()
	
func test():
	return true
	
func run():
	EventBus.pause.emit()
	if UpgradeList.relicData['wishbone']:
		j.setDam(j.getDam() * 0.5)
	EventBus.throwEffect.emit(j)
	if UpgradeList.relicData['wishbone']:
		await EventBus.get_tree().create_timer(0.3).timeout
		EventBus.throwEffect.emit(j)
	EventBus.unpause.emit()
