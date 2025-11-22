extends Node2D
class_name UpgradeListd

var allAttributes: Array = []
var byType: Dictionary = {"onHit" = [], "onDamaged" = [], "passives" = []
, "actives" = [], "meters" = [], "onCondition" = []}

func addAttribute(a: Attribute):
	allAttributes.append(a)
	byType[a.type].append(a)

func getByType(t: String):
	return byType[t]
