extends CanvasLayer

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS  # biar node ini tetep jalan walau game di-pause

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused


func _on_button_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_button_2_pressed() -> void:
	get_tree().quit()
