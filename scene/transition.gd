extends CanvasLayer

@onready var fade_rect: ColorRect = $FadeRect

func _ready() -> void:
	layer = 99
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func ganti_scene(path: String, durasi_hold: float = 1.0) -> void:
	fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP

	# FADE IN -> layar jadi gelap
	var tween_in = create_tween()
	tween_in.tween_property(fade_rect, "color:a", 1.0, 0.5)
	await tween_in.finished

	# HOLD -> diem beberapa detik gelap total
	await get_tree().create_timer(durasi_hold).timeout

	# GANTI SCENE pas layar masih gelap
	get_tree().change_scene_to_file(path)

	# tunggu 1 frame biar scene baru beneran kelar dimuat
	await get_tree().process_frame

	# FADE OUT -> nampilin scene baru
	var tween_out = create_tween()
	tween_out.tween_property(fade_rect, "color:a", 0.0, 0.5)
	await tween_out.finished

	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
