"""
Node that dictates where an attack will be launched from, how the targeting effects will appear,
and what attack animation is to be played.
"""

extends Node2D
@onready var attack: Node2D = $Attack

func _ready() -> void:
	EventBus.attack.connect(_attack)
	EventBus.updateAOE.connect(_updateAOE)

func _attack(weapon: Array):
	# Function that calls for a certain attacking animation based on what attack type the weapon uses
	# param - weapon: The weapon data from the WeaponSlot
	if weapon[4] == "slashing":
		attack.slash(Vector2(weapon[1], weapon[2]))
	
	
	
func _updateAOE(width: int, height: int, pointOfOrigin: Vector2):
	# Function that updates how the targeted areas should be displayed based on the stats of the weapon
	# param - width: How many tiles wide the weapon strikes
	# param - height: How many tiles tall does the weapon strike
	# pointOfOrigin: Where the attack will be centered, typically on the player, but some may be centered in the middle of the floor
	
	# Sets the point of origin as the position of this node
	position += pointOfOrigin
	
	# Delete any pre-existing target effects
	for i in self.get_children():
		if i is AreaOfEffect:
			remove_child(i)
	
	# Depending on the dimentions, generate a new targeted area
	for i in range(-(width/2), width/2 + 1):
		for j in range(0, height):
			var area = preload("res://scenes/AreaOfEffect.tscn").instantiate()
			area.position.x = position.x + (i*16)
			area.position.y = position.y - (j * 16) - 16
			add_child(area)
	
	
