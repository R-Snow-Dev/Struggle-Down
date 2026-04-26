extends Label
class_name DamagePopup

var decay = 0.0

func setup(num: int) -> void:
	if num >=0 :
		add_theme_color_override("font_color", Color(255,255,255,1))
		add_theme_color_override("font_outline_color", Color(0,0,0,100))
	else:
		add_theme_color_override("font_color", Color(0,0,0,100))
		add_theme_color_override("font_outline_color", Color(255,255,255,1))
	text = str(int(num)) + "AB"
	
func _ready() -> void:
	position.y -= 2
	await get_tree().create_timer(1).timeout
	call_deferred("queue_free")

func _process(delta: float) -> void:
	position.y -= 0.7 - decay
	modulate -= Color(0,0,0, 3  * delta)
	decay += 0.007 + delta
