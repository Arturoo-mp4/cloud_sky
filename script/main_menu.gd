extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_p_lay_pressed() -> void:
	
	Transition.ganti_scene("res://scene/main.tscn", 1)

func _on_quit_pressed() -> void:
	get_tree().quit()
