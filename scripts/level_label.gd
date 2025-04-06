extends Label

var displayedText = str(0)

func _ready() -> void:
	EventBus.update_level.connect(_update_text)
	self.text = displayedText
	
func _update_text(num: int):
	displayedText = str(num)
	self.text = displayedText
