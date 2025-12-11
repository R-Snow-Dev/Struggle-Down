extends Node2D

var everything = [SwordMastery.new(), CriticalHit.new(), BleedChance.new(), Parry.new(), 
QuickDraw.new(), SwordSaint.new(), Serration.new(), ExtremePolish.new(), SwordAxiom.new()]
var allAttributes: Array = []
var byType: Dictionary = {"onHit" = [], "onDamaged" = [], "passive" = []
, "active" = [], "meter" = [], "onCondition" = [], "onAttack" = []}

var upgradeTable = {
	"Sword":[SwordMastery.new(), SwordMastery.new(), SwordMastery.new(), SwordMastery.new(), SwordMastery.new(), SwordMastery.new(),
				CriticalHit.new(), CriticalHit.new(), CriticalHit.new(), CriticalHit.new(), CriticalHit.new(), CriticalHit.new(),
				BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), 
				Parry.new(), Parry.new(), Parry.new(), Parry.new(), Parry.new(),
				QuickDraw.new(), QuickDraw.new(), QuickDraw.new(),  QuickDraw.new(),
				SwordSaint.new(), SwordSaint.new(), 
				Serration.new(), Serration.new(), 
				ExtremePolish.new(), ExtremePolish.new(), 
				SwordAxiom.new()]}

func findInEv(a: Attribute) -> int:
	for x in range(0, everything.size()):
		if a.name == everything[x].name:
			return x
	return -1

func saveToFile():
	SaveController.resetUps()
	for x in allAttributes:
		SaveController.addUp(findInEv(x))

func addFromSave():
	var s = SaveController.getData("upgrades")
	for a in s:
		addAttribute(everything[int(a)])

func addAttribute(a: Attribute):
	allAttributes.append(a)
	byType[a.type].append(a)
	EventBus.uCont.emit(a)
	print(a.name)
	a.onPickup(self)

func getByType(t: String):
	return byType[t]

func reset():
	EventBus.rUCont.emit()
	byType = {"onHit" = [], "onDamaged" = [], "passive" = []
	, "active" = [], "meter" = [], "onCondition" = [], "onAttack" = []}
	allAttributes = []
