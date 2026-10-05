extends BossNew
class_name RatChamp

@onready var sprite = $AnimatedSprite2D
@onready var hBox = $hitbox
@onready var sBox = $spearBox
@onready var sCollider = $spearBox/CollisionShape2D
@onready var anim = $AnimationPlayer
@onready var sKing = $"Slash King"
@onready var bP = $BashParts

var pActions: int = 0

func _process(_delta: float) -> void:
	var c: ClearScreen = Overseer.getController().clear
	c.reset()
	pos = getData().getPos()
	if isDead():
		if !paid:
			paid = true
			if UpgradeList.maxDrops:
				EventBus.updateGold.emit(getData().getGoldRange().y)
			else:
				EventBus.updateGold.emit(rng.randi_range(getData().getGoldRange().x, getData().getGoldRange().y))
		Overseer.getBoard().nextGuy()
		Overseer.getController().unlockRelic(2)
		c.addAdded(preload("res://scenes/GUIParts/soul_flame.tscn").instantiate())
		c.on()
		EventBus.object_ded.emit(self)

func _ready() -> void:
	setHbox(hBox)
	pActions = SaveController.getData('pActions')
	var d = pActions - 3
	if d<0:
		d = 0
	getData().setMaxActions(4 + d)
	EventBus.object_ded.connect(summon_plz)

func summon_plz(o:Node) -> void:
	if o is EvilRat:
		getData().getBehavior().summon = true

func toggleBump() -> void:
	getData().setBump(!getData().getBump())

func setAttackBox(x: int, y: int) -> void:
	sCollider.shape.size = Vector2(x,y)
	var f = getData().getFacing()
	if f == Vector2(0,-1):
		sCollider.position = sCollider.sU
	elif f == Vector2(0,1):
		sCollider.position = sCollider.sD
	else:
		sCollider.shape.size = Vector2(y,x)
		sCollider.position = Vector2(sCollider.sS.x * f.x, sCollider.sS.y)

func move(grid: gameBoard, target: Player) -> void:
	activateEffects(0)
	if getData().getActions() > 0:
		getData().getBehavior().setMyself(self) # Sets the target of the AI calculations to itself
		getData().think(grid, target) # Tells the AI class to perform it's operations
		getData().getBehavior().getGrid().loadGrid() # Redraws the grid
		await get_tree().create_timer(getDelay()).timeout # Waits a lil bit
		activateEffects(1)
		if getData().getActions() > 0: # Chhecks to see if it has any actions left to perform
			move(grid, target) # If so, do it again
		else:
			Overseer.getBoard().nextGuy() # Otherwise, tell the board that ur done
	else:
			Overseer.getBoard().nextGuy() # Otherwise, tell the board that ur done

func chooseState() -> void:
	# Chooses what animations to play based on the direction it is facing
	sKing.position.y = 0
	sKing.position.x = 0
	var f = getData().getFacing()
	if f == Vector2(-1,0):
		setCurState("s")
		sprite.play('idle-s')
		sKing.position.x = 8
		sKing.rotation_degrees = 90
		sprite.flip_h = false
	elif f == Vector2(1,0):
		setCurState("s")
		sprite.play('idle-s')
		sKing.position.x = -8
		sKing.rotation_degrees = 270
		sprite.flip_h = true
	elif f == Vector2(0,1):
		setCurState("d")
		sprite.play('idle-d')
		sKing.rotation_degrees = 0
		sprite.flip_h = false
	elif f == Vector2(0,-1):
		setCurState("u")
		sprite.play('idle-u')
		sKing.rotation_degrees = 180
		sKing.position.y = 16
		sprite.flip_h = false
	else:
		sKing.rotation_degrees = 0
		sprite.flip_h = false

func pPos() -> void:
	getData().setPos(getData().getBehavior().ideal - getData().getFacing())
	draw()

func draw() -> void:
	super()
	position.y -= 12

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is not SpearBox:
		print('hBox')
		onHit(area)
		bP.emitting = true

func _on_spear_box_area_entered(area: Area2D) -> void:
	print('sBox')
	if area is Player:
		EventBus.update_hp.emit(-getData().getBehavior().nextAttack.dam)
		for x: Attribute in UpgradeList.getByType("onAttacked"):
			x.effect(self)
