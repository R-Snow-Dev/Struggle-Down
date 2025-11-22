extends Node
class_name Armory

var weapons = [[],
	Weapon.new("Sword","slash",7,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true),
	Weapon.new("Great Sword","slash",10,2,Vector2(0,1),Vector2i(3,2),Vector2(0,0),true),
	Mace.new("Mace","blunt",0,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true),
	Weapon.new("Spear","pierce",7,1,Vector2(0,1),Vector2i(1,3),Vector2(0,0),true),
	Halberd.new("Halberd","slash",5,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true),
	Stiletto.new("Stiletto","pierce",3,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true)]

var damages = {"slash" = 0, "pierce" = 0, "blunt" = 0, "shockwave" = 0,
"frost" = 0, "explosive" = 0, "shock" = 0, "fire" = 0, "holy" = 0}

var held: int = 0

func reset() -> void:
	weapons = [[],
	Weapon.new("Sword","slash",7,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true),
	Weapon.new("Great Sword","slash",10,2,Vector2(0,1),Vector2i(3,2),Vector2(0,0),true),
	Mace.new("Mace","blunt",0,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true),
	Weapon.new("Spear","pierce",7,1,Vector2(0,1),Vector2i(1,3),Vector2(0,0),true),
	Halberd.new("Halberd","slash",5,1,Vector2(0,1),Vector2i(3,1),Vector2(0,0),true),
	Stiletto.new("Stiletto","pierce",3,0,Vector2(0,1),Vector2i(1,1),Vector2(0,0),true)]

	damages = {"slash" = 0, "pierce" = 0, "blunt" = 0, "shockwave" = 0,
	"frost" = 0, "explosive" = 0, "shock" = 0, "fire" = 0, "holy" = 0}
	
	held = 0
	
