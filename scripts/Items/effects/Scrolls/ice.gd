extends ItemEffect
class_name IceScrollEffect

var mag: int
var s = preload("res://scenes/Projectiles/Sprites/ice.tscn").instantiate()
var j: Projectile 

func _init(m: int) -> void:
	mag = m
	j = WeaponList.createNewProj(s, false, Vector2(0,100), true, Color(255,255,255,0.5), 'none', 4 + mag, 'slow', 0.4 + (0.1 * mag))

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
