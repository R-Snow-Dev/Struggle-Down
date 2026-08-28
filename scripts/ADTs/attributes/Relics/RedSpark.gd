extends Attribute
class_name RSpark

func _init() -> void:
	type = "passive"
	name = "Red Spark"
	description = "A shard of Wrath's dominion. Draw power from Pandemonium.\n
	All damage done is doubled when under the effects of Wrath."

func onPickup(target : Node):
	UpgradeList.setRData('spark', true)
