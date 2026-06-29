extends CanvasLayer

@onready var color_rect: ColorRect = $FadeRect


func _ready() -> void:
	layer = 99
	color_rect.color = Color(0, 0, 0, 0)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func ganti_scene(path: String, durasi_hold: float = 1.0) -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP

	
	var tween_in = create_tween()
	tween_in.tween_property(color_rect, "color:a", 1.0, 0.5)
	await tween_in.finished

	await get_tree().create_timer(durasi_hold).timeout

	get_tree().change_scene_to_file(path)
	
	await get_tree().process_frame
	var tween_out = create_tween()
	tween_out.tween_property(color_rect, "color:a", 0.0, 0.5)
	await tween_out.finished

	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
#
