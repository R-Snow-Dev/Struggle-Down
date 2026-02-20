extends Node2D

var everything = [SwordMastery.new(), CriticalHit.new(), BleedChance.new(), Parry.new(), 
QuickDraw.new(), SwordSaint.new(), Serration.new(), ExtremePolish.new(), SwordAxiom.new(), 
GSMastery.new(), Momentum.new(), Massive.new(), Overkill.new(), SteelHeart.new(), ExtendoBlade.new(),
SimpleStrength.new(), MaceMastery.new(), Rattled.new(), GiantSlam.new(), WindUP.new(), 
ConcussionCertified.new(), StrategicWeaponry.new(), BusterBash.new(), SpearMastery.new(), SharpSoul.new(), 
Charge.new(), Paranoia.new(), Lunge.new(), Focus.new(), GiantKiller.new(), Hone.new(), SliceSpecialist.new(), 
StabSpecialist.new(), SuperAdapt.new(), SoldierSoul.new(), CavalrySoul.new(), WarSoul.new(), 
StilettoMastery.new(), Exploit.new(), Cloaking.new(), Nimble.new(), Deadly.new(), Efficient.new()]
var allAttributes: Array = []
var byType: Dictionary = {"onHit" = [], "onDamaged" = [], "passive" = []
, "active" = [], "meter" = [], "onCondition" = [], "onAttack" = [], "onKill" = []}

var upgradeTable = {
	"Sword":[SwordMastery.new(), SwordMastery.new(), SwordMastery.new(), SwordMastery.new(), SwordMastery.new(), SwordMastery.new(),
				CriticalHit.new(), CriticalHit.new(), CriticalHit.new(), CriticalHit.new(), CriticalHit.new(), CriticalHit.new(),
				BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), 
				Parry.new(), Parry.new(), Parry.new(), Parry.new(),
				QuickDraw.new(), QuickDraw.new(), QuickDraw.new(),  QuickDraw.new(),
				SwordSaint.new(), SwordSaint.new(), 
				Serration.new(), Serration.new(), 
				ExtremePolish.new(), ExtremePolish.new(), 
				SwordAxiom.new()],
	"Great Sword":[GSMastery.new(), GSMastery.new(), GSMastery.new(), GSMastery.new(), GSMastery.new(), GSMastery.new(),  GSMastery.new(),
					Momentum.new(), Momentum.new(), Momentum.new(), Momentum.new(), Momentum.new(), Momentum.new(), Momentum.new(), 
					Massive.new(), Massive.new(), Massive.new(), Massive.new(), 
					Overkill.new(), Overkill.new(), Overkill.new(), Overkill.new(), 
					SteelHeart.new(), SteelHeart.new(), 
					ExtendoBlade.new(), ExtendoBlade.new(), 
					SimpleStrength.new()],
	"Mace": [MaceMastery.new(), MaceMastery.new(), MaceMastery.new(), MaceMastery.new(), MaceMastery.new(), MaceMastery.new(), MaceMastery.new(),
				Rattled.new(), Rattled.new(), Rattled.new(), Rattled.new(), Rattled.new(), Rattled.new(), Rattled.new(), 
				GiantSlam.new(), GiantSlam.new(), GiantSlam.new(), GiantSlam.new(), GiantSlam.new(),
				WindUP.new(), WindUP.new(), WindUP.new(), WindUP.new(),
				ConcussionCertified.new(), ConcussionCertified.new(),
				StrategicWeaponry.new(), StrategicWeaponry.new(),
				BusterBash.new()],
	"Spear": [SpearMastery.new(), SpearMastery.new(), SpearMastery.new(), SpearMastery.new(), SpearMastery.new(), SpearMastery.new(),
				BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(),
				SharpSoul.new(), SharpSoul.new(), SharpSoul.new(), SharpSoul.new(),
				Charge.new(), Charge.new(), Charge.new(), Charge.new(),
				Paranoia.new(), Paranoia.new(), Paranoia.new(),
				Lunge.new(), Lunge.new(),
				Focus.new(), Focus.new(),
				GiantKiller.new()],
	"Halberd": [SharpSoul.new(), SharpSoul.new(), SharpSoul.new(), SharpSoul.new(), SharpSoul.new(), SharpSoul.new(), 
				Hone.new(), Hone.new(), Hone.new(), Hone.new(), Hone.new(), Hone.new(), 
				SliceSpecialist.new(), SliceSpecialist.new(), SliceSpecialist.new(),
				StabSpecialist.new(), StabSpecialist.new(), StabSpecialist.new(), 
				SuperAdapt.new(), SuperAdapt.new(), 
				SoldierSoul.new(), SoldierSoul.new(), 
				CavalrySoul.new(), CavalrySoul.new(),
				WarSoul.new()],
	"Stiletto": [StilettoMastery.new(), StilettoMastery.new(), StilettoMastery.new(), StilettoMastery.new(), StilettoMastery.new(), StilettoMastery.new(), 
					BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(), BleedChance.new(),
					Exploit.new(), Exploit.new(), Exploit.new(), Exploit.new(), Exploit.new(), Exploit.new(),
					Cloaking.new(), Cloaking.new(), Cloaking.new(),Cloaking.new(),
					SharpSoul.new(), SharpSoul.new(), SharpSoul.new(), SharpSoul.new(), 
					Nimble.new(), Nimble.new(),
					Deadly.new(), Deadly.new(),
					Efficient.new()]}

var maxDrops = false

func setMax(b: bool) -> void:
	maxDrops = b

func findInEv(a: Attribute) -> int:
	for x in range(0, everything.size()):
		if a.name == everything[x].name:
			return x
	return -1

func saveToFile():
	SaveController.resetUps()
	for x in allAttributes:
		if x is Brand:
			SaveController.updateData("stored", x.stored)
		SaveController.addUp(findInEv(x))

func addFromSave():
	print("Yeah Baby")
	var s = SaveController.getData("upgrades")
	for a in s:
		var attribute = everything[int(a)]
		if attribute is Brand:
			attribute.stored = SaveController.getData("stored")
		addAttribute(attribute)

func addAttribute(a: Attribute):
	allAttributes.append(a)
	byType[a.type].append(a)
	EventBus.uCont.emit(a)
	print(a.name)
	a.onPickup(self)
	EventBus.updateActions.emit(0, "move")

func getByType(t: String):
	return byType[t]

func reset():
	EventBus.rUCont.emit()
	byType = {"onHit" = [], "onDamaged" = [], "passive" = []
	, "active" = [], "meter" = [], "onCondition" = [], "onAttack" = [], "onKill" = []}
	allAttributes = []
	maxDrops = false
