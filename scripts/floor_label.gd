'''
Displays the current floor on the GUI
'''

extends Label

@onready var data = SaveController.loadData()
var displayedText: String

func _ready() -> void:
	displayedText = str(data["floor"])
	
func _process(delta: float) -> void:
	self.text = displayedText
