extends Node2D
class_name RoamingReticle

var sp: Node
var lf: float = 0.1
var id: int = 0
var p: Attribute
var size: Vector2 = Vector2(1,1)
@onready var r: AreaOfEffect = $AreaOfEffect

func setSize(s: Vector2) -> void:
	size = s
	
func setParent(a: Attribute) -> void:
	p = a

func setId(i: int) -> void:
	id = i

func setSprite(s: Node) -> void:
	sp = s
	
func setLifespan(amount: float) -> void:
	lf = amount

func _process(delta: float) -> void:
	var mP = get_global_mouse_position() + Vector2(8,8)
	global_position = (Vector2i(mP) - Vector2i((int(mP.x) % 16), (int(mP.y) % 16)))
	if global_position >= Vector2(0,0) and global_position < (Overseer.control.gridSize - Vector2(1,1)) * 16:
		visible = true
	else:
		visible = false
	if Input.is_action_just_pressed("select") and visible:
		var dS: DelayedStrike = preload("res://scenes/DungeonParts/delayed_strike.tscn").instantiate()
		dS.setId(id)
		dS.setLifespan(lf)
		dS.setSprite(sp)
		dS.setSize(size)
		dS.global_position = global_position
		dS.position.y -= 8
		Overseer.control.add_child(dS)
		p.effectDone.emit()
		call_deferred("queue_free")
