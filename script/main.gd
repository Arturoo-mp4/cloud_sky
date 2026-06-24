extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var phase_label: Label = $CanvasLayer/PhaseLabel
@onready var camera_2d: Camera2D = $Camera2D
@onready var defeat_screen: CanvasLayer = $Defeat_Screen

@onready var portal: Node2D = $Portal


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PhaseManager.phase_changed.connect(_on_phase_changed)
	defeat_screen.visible = false
	portal.hide()
	portal.process_mode = Node.PROCESS_MODE_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#	_game_over()
	var sisa = int(PhaseManager.get_time_left())
	var fase = PhaseManager._get_phase()
	phase_label.text = "Fase %d %ds " % [fase, sisa]
	
	
	if player.global_position.y >= 600:
		_game_over() 
	
	
	
	
	
	
func _on_phase_changed(new_phase: int) -> void:
	print("Fase ganti ke: ", new_phase)
	if new_phase == 5:
		_start_boss_transition()
func _start_boss_transition() -> void:
	#camera_2d.reparent(player)
	portal.process_mode = Node.PROCESS_MODE_INHERIT
	portal.show()
	
	
	#_camera_transition()

func _camera_transition() -> void:
	var tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(1.0, 1.0), 2)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	camera_2d.position = Vector2.ZERO


func _game_over() -> void:
	defeat_screen.visible = true
	PhaseManager.game_over.emit()
	PhaseManager.is_game_aktif = false
	
