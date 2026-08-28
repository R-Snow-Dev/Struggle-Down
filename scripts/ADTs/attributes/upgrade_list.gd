extends Node2D

var rng = RandomNumberGenerator.new()

var everything = [SwordMastery.new(), CriticalHit.new(), BleedChance.new(), Parry.new(), 
QuickDraw.new(), SwordSaint.new(), Serration.new(), ExtremePolish.new(), SwordAxiom.new(), 
GSMastery.new(), Momentum.new(), Massive.new(), Overkill.new(), SteelHeart.new(), ExtendoBlade.new(),
SimpleStrength.new(), MaceMastery.new(), Rattled.new(), GiantSlam.new(), WindUP.new(), 
ConcussionCertified.new(), StrategicWeaponry.new(), BusterBash.new(), SpearMastery.new(), SharpSoul.new(), 
Charge.new(), Paranoia.new(), Lunge.new(), Focus.new(), GiantKiller.new(), Hone.new(), SliceSpecialist.new(), 
StabSpecialist.new(), SuperAdapt.new(), SoldierSoul.new(), CavalrySoul.new(), WarSoul.new(), 
StilettoMastery.new(), Exploit.new(), Cloaking.new(), Nimble.new(), Deadly.new(), Efficient.new(),
ColdSnap.new(), HoarFrost.new(), Finepoint.new(), Permafrost.new(), Rime.new(), CrystalShell.new(),
EnchantIce.new(), IceAge.new(), Harmonic.new(), ExploitWeakness.new(), QSMaster.new(), EnchantEarth.new(), 
Foreshock.new(), Hypocenter.new(), Oxidizer.new(), HeatUp.new(), Detonate.new(), Chaos.new(), EnchantFire.new(),
Fission.new(), HighVoltage.new(), LockUp.new(), EnchantStorm.new(), Overclock.new(), Bioshock.new(),
STwice.new(), Generator.new(), WindMastery.new(), Tailwind.new(), Gale.new(), Typhoon.new(), Sirocco.new(),
Formless.new(), Vampyrism.new(), Immolate.new(), Punishment.new(), Harvest.new(), Infernal.new(), 
Bless.new(), Luck.new(), Golden.new(), DivineProtection.new(), GrandBlessing.new(), EnchantHoly.new(),
Angel.new(), LakeBlessing.new(), BranchBlessing.new(), MoonBlessing.new(), Brand.new(), TrollBlessing.new(),
MeteorBlessing.new(), HolyBlessing.new(), DemonBlessing.new(), NancyBlessing.new(), Kingsoul.new(), 
Betrayer.new(), RegalBlessing.new(), NeptuneBlessing.new(), BlackCurse.new(), WrathBlessing.new(), RichterBlessing.new(),
]

var allAttributes: Array = []
var byType: Dictionary = {"onHit" = [], "onDamaged" = [], "passive" = []
, "active" = [], "meter" = [], "onCondition" = [], "onAttack" = [], "onKill" = [], 
	"onRoom" = [], 'hitMult' = [], "onAttacked" = [], 'onMove' = []}

var relics = [WWScabbard.new(), AMap.new(), FKnife.new(), MinorArcana.new(), DTassel.new(), LFocus.new(),
			GStandard.new(), IDepiction.new(), LChalice.new(), AStatuette.new(), CImmaculate.new(), SGrace.new(),
			AWishbone.new(), FPesilence.new(), RSpark.new(), PStarter.new(), USymbol.new(), Libra.new()]

var relicIdByLevel = [[0,3],[4,6,7,9],[10,11,12,13,14,16,17,18]]

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
					Efficient.new()],
	"Ice Wand": [ColdSnap.new(),ColdSnap.new(),ColdSnap.new(),ColdSnap.new(),ColdSnap.new(),ColdSnap.new(),
				HoarFrost.new(),HoarFrost.new(),HoarFrost.new(),HoarFrost.new(),HoarFrost.new(),HoarFrost.new(),
				Finepoint.new(),Finepoint.new(),Finepoint.new(),Finepoint.new(),Finepoint.new(),Finepoint.new(),
				Permafrost.new(),Permafrost.new(),Permafrost.new(),Permafrost.new(),
				Rime.new(),Rime.new(),Rime.new(),Rime.new(),
				CrystalShell.new(), CrystalShell.new(),
				EnchantIce.new(),EnchantIce.new(),
				IceAge.new()],
	"Quake Staff": [Harmonic.new(),Harmonic.new(),Harmonic.new(),Harmonic.new(),Harmonic.new(),Harmonic.new(),
					ExploitWeakness.new(),ExploitWeakness.new(),ExploitWeakness.new(),ExploitWeakness.new(),ExploitWeakness.new(),ExploitWeakness.new(),
					QSMaster.new(),QSMaster.new(),QSMaster.new(),QSMaster.new(),
					EnchantEarth.new(),EnchantEarth.new(),EnchantEarth.new(),EnchantEarth.new(),
					Rattled.new(),Rattled.new(),
					Foreshock.new(), Foreshock.new(),
					Hypocenter.new()],
	"Unstable Wand": [Oxidizer.new(),Oxidizer.new(),Oxidizer.new(),Oxidizer.new(),Oxidizer.new(),Oxidizer.new(),
					HeatUp.new(),HeatUp.new(),HeatUp.new(),HeatUp.new(),HeatUp.new(),HeatUp.new(),
					Overkill.new(),Overkill.new(),Overkill.new(),Overkill.new(),
					Detonate.new(),Detonate.new(),Detonate.new(),Detonate.new(),
					Chaos.new(),Chaos.new(),
					EnchantFire.new(), EnchantFire.new(),
					Fission.new()],
	"Thunder Gem": [HighVoltage.new(),HighVoltage.new(),HighVoltage.new(),HighVoltage.new(),HighVoltage.new(),HighVoltage.new(),
					LockUp.new(),LockUp.new(),LockUp.new(),LockUp.new(),LockUp.new(),LockUp.new(),
					EnchantStorm.new(),EnchantStorm.new(),EnchantStorm.new(),EnchantStorm.new(),
					Overclock.new(),Overclock.new(),Overclock.new(),Overclock.new(),
					Bioshock.new(), Bioshock.new(),
					STwice.new(), STwice.new(),
					Generator.new()],
	"Wind Charm": [Hone.new(),Hone.new(),Hone.new(),Hone.new(),Hone.new(),Hone.new(),
					WindMastery.new(),WindMastery.new(),WindMastery.new(),WindMastery.new(),WindMastery.new(),WindMastery.new(),
					Tailwind.new(),Tailwind.new(),Tailwind.new(),Tailwind.new(),
					Gale.new(),Gale.new(),Gale.new(),Gale.new(),
					Typhoon.new(), Typhoon.new(),
					Sirocco.new(), Sirocco.new(),
					Formless.new()],
	"Demon Horn": [Vampyrism.new(), Vampyrism.new(),Vampyrism.new(),Vampyrism.new(),Vampyrism.new(),Vampyrism.new(),\
					Immolate.new(),Immolate.new(),Immolate.new(),Immolate.new(),Immolate.new(),Immolate.new(),
					HeatUp.new(),HeatUp.new(),HeatUp.new(),HeatUp.new(),
					Punishment.new(),Punishment.new(),Punishment.new(),Punishment.new(),
					EnchantFire.new(), EnchantFire.new(),
					Harvest.new(), Harvest.new(),
					Infernal.new()],
	"Holy Scepter": [Bless.new(),Bless.new(),Bless.new(),Bless.new(),Bless.new(),Bless.new(),
					Luck.new(),Luck.new(),Luck.new(),Luck.new(),Luck.new(),Luck.new(),
					Golden.new(),Golden.new(),Golden.new(),Golden.new(),
					DivineProtection.new(),DivineProtection.new(),DivineProtection.new(),DivineProtection.new(),
					GrandBlessing.new(), GrandBlessing.new(),
					EnchantHoly.new(), EnchantHoly.new(),
					Angel.new()]}
					
var titleUpgrades = {'Sword': [LakeBlessing.new(), BranchBlessing.new()],
					'Great Sword': [MoonBlessing.new(), Brand.new()],
					'Mace': [TrollBlessing.new(), MeteorBlessing.new()],
					'Spear': [HolyBlessing.new(), DemonBlessing.new()],
					'Halberd': [NancyBlessing.new(), Kingsoul.new()],
					'Stiletto': [Betrayer.new(), RegalBlessing.new()],
					'Ice Wand': [NeptuneBlessing.new(), BlackCurse.new()],
					'Quake Staff': [WrathBlessing.new(),RichterBlessing.new()],
					'Unstable Wand': [Attribute.new(),Attribute.new()],
					'Lightning Gem': [Attribute.new(),Attribute.new()],
					'Wind Charm': [Attribute.new(),Attribute.new()],
					'Demon Horn': [Attribute.new(),Attribute.new()],
					'Holy Scepter': [Attribute.new(),Attribute.new()]}

var maxDrops = false

var noHit = true

var shields = 0

var cShields = 0

var charge = 0

var chargeable = false

var lifesteal = 0

var lifeLimit = 24

var angel = 0

var relicData = {"decoys": 1,
				"swords": false,
				"dropAttempts": 1,
				'arcana': false,
				"meleeMult": 1.0,
				"magMult": 1.0,
				"goldMult": false,
				'immaterial': false,
				'chalice': false,
				'angel': false,
				'immaculate': false,
				'wishbone': false,
				'pestilence': 1.0,
				'spark': false,
				'consumptionChance': 1.0,
				'libra': false}

func setNoHit(v: bool = false) -> void:
	noHit = v

func getNoHit() -> bool:
	return noHit

func setRData(data: String, value) -> void:
	relicData[data] = value

func resetRData() -> void:
	pass

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
		if findInEv(x) >= 0:
			SaveController.addUp(findInEv(x))

func addFromSave():
	print("Yeah Baby")
	var s = SaveController.getData("upgrades")
	var r: Array = SaveController.getData("relics")
	for relic in r:
		if relic is not bool:
			var a = relics[relic]
			addAttribute(a)
	for a in s:
		if a >= 0:
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

func addRandom() -> void:
	var seed = SaveController.getData("seed")
	rng.seed = seed
	addAttribute(everything[rng.randi_range(0, len(everything) - 1)])
	saveToFile()

func getByType(t: String):
	return byType[t]

func reset():
	EventBus.rUCont.emit()
	byType = {"onHit" = [], "onDamaged" = [], "passive" = []
	, "active" = [], "meter" = [], "onCondition" = [], "onAttack" = [], "onKill" = [], 
	"onRoom" = [], 'hitMult' = [], "onAttacked" = [], 'onMove' = []}
	allAttributes = []
	maxDrops = false
	noHit = true
	shields = 0
	cShields = 0
	charge = 0
	chargeable = false
	lifesteal = 0
	angel = 0
	relicData = {"decoys": 1,
				"swords": false,
				"dropAttempts": 1,
				'arcana': false,
				"meleeMult": 1.0,
				"magMult": 1.0,
				"goldMult": false,
				'immaterial': false,
				'chalice': false,
				'angel': false,
				'immaculate': false,
				'wishbone': false,
				'pestilence': 1.0,
				'spark': false,
				'consumptionChance': 1.0,
				'libra': false}
	
