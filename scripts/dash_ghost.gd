extends Sprite2D


func _ready() -> void:
	var my_tween = get_tree().create_tween()
	my_tween.tween_property(self, "modulate:a", 0, 1)
	my_tween.finished.connect(remove)
	
func remove():
	print_debug("Removing ghost")
	queue_free()
