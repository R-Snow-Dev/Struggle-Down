extends Node2D
class_name WrathCounter

var pos: Vector2

var locked := false

@onready var counter = $"Number Display/Label"
@onready var display = $"Number Display"
@onready var sprite = $AnimatedSprite2D

const DELAY = 1.0

@export var count := 0

func _ready() -> void:
	EventBus.updateActions.connect(updateActions)
	counter.text = str(count)

func setup(p: Vector2):
	# Function that must be called after creating an instance, so that its characteristics may be given to it
	# param - p: The position of the wall in Vector2 form
	pos = p
	return self

func myName() -> String:
	return "wall"

func getPos() -> Vector2:
	return pos

# While a Wall is an object, it cannot move, so it passes instead
func move():
	pass

func animate() -> void:
	if count > 0:
		sprite.play('Switch')
		await get_tree().create_timer(DELAY/5.0).timeout
		counter.text = str(count)
	else:
		EventBus.pause.emit()
		sprite.play("Smash")
		await get_tree().create_timer(DELAY).timeout
		display.visible = false
		Overseer.setWrath(true)
		await sprite.animation_finished
		EventBus.unpause.emit()
		var map = get_parent()
		var chosenFiend: Fiend = preload("res://scenes/Opps/demon.tscn").instantiate()
		var behavior = DemonBehavior.new()
		map.remove_child(self)
		chosenFiend.setData(pos, 200, 3, Vector2(0,1), 2, Vector2(0,-1), behavior,[], {'fire': 0.0, 'holy': 1.50, 'slash': 0.50, 'pierce': 0.50, 'blunt': 0.50, 'cold': 1.25}) # Adds all relevant information to the newly spawned fiend
		chosenFiend.magic = true
		Overseer.board.objects.append(chosenFiend)
		map.add_child(chosenFiend)
		EventBus.object_ded.emit(self)

func updateActions(amount: int, _type: String) -> void:
	if amount < 0 and get_tree() and !locked:
		count += amount
		animate()
		
func reset() -> void:
	pass

func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16 - 16
	self.z_index = (pos.y + 2)
