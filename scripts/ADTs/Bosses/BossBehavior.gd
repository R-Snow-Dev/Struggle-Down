extends Behavior
class_name BossBehavior

var curAttack: BossAttack
var prepped: bool = false

func setAttack(a: BossAttack) -> void:
	curAttack = a

func getAttack() -> Attack:
	return curAttack
	
func setPrepped(b:bool) -> void:
	prepped = b
	
func isPrepped() -> bool:
	return prepped
