extends Attribute
class_name NancyBlessing

func _init() -> void:
	type = "onKill"
	name = "Remembrance of Nancy"
	description = "The halberdiers of Nancy knew no fear. Their order was revered as the most mighty of human forces. Though faded, the lagacy of the order has been passed down through generations. Even time has yet to best it. It is you, now, who carries their name.
	
	Killing enemies recovers 1 action.
	"

func effect(target: Node) -> int:
	EventBus.updateActions.emit(1)
	effectDone.emit()
	return 0
