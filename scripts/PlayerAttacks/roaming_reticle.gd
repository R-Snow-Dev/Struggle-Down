extends Node2D
class_name teleport

signal all_done
@onready var r: AreaOfEffect = $AreaOfEffect

func _process(delta: float) -> void:
	var mP = get_global_mouse_position() + Vector2(8,8)
	global_position = (Vector2i(mP) - Vector2i((int(mP.x) % 16), (int(mP.y) % 16)))
	if global_position >= Vector2(0,0) and global_position < (Overseer.control.gridSize - Vector2(1,1)) * 16:
		visible = true
	else:
		visible = false
	if Input.is_action_just_pressed("select") and visible:
		if Overseer.getGrid()[global_position.y/16][global_position.x/16].size() < 1:
			Overseer.board.teleport(global_position/16)
			all_done.emit()
			call_deferred("queue_free")
