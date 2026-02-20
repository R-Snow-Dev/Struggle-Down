extends BossAttack
class_name KingSummon

var positions = []
var rng = RandomNumberGenerator.new()

func warn() -> void:
	positions = []
	var pos = atckr.getData().getPos()
	var g = atckr.getData().getBehavior().getGrid()
	for x in range(rng.randi_range(0,1),11,2):
		for y in range(rng.randi_range(0,1),11,2):
			if !g.grid[x][y]:
				if rng.randf() > 0.75:
					positions.append(Vector2(x,y))
					EventBus.warn.emit((Vector2(x,y) - pos) + Vector2(0,-0.75), (Vector2(x,y) - pos) - Vector2(1,0))
	
func attack():
	for v in positions:
		EventBus.createSlime.emit(v)
	atckr.setDelay(0.2)
