extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	PhaseManager._kalah()
	get_tree().quit()


func _on_play_again_pressed() -> void:
	PhaseManager._kalah()
	get_tree().reload_current_scene()
	print("Berhasil reload")
