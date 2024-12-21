extends "res://scripts/AttackingLogic/AttackBehavior.gd"



func _init(dam: int, atker: PackedScene) -> void:
	super(dam, atker)
	
func attack():
	var start = self.atker.pos
	var target: Vector2
	if self.atker.facing == "up":
		target = start + Vector2(0,1)
	elif self.atker.facing == "down":
		target = start + Vector2(0,-1)
	elif self.atker.facing == "left":
		target = start + Vector2(-1,0)
	elif self.atker.facing == "right":
		target = start + Vector2(1,0)
		
	self.atker.pos = target
	self.atker.draw()
