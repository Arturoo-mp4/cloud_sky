extends Node
var time := 0.0
var phase_sekarang := 1.0
var is_game_aktif := true
var new_phase := 1.0

signal phase_changed(new_phase)
signal game_over
signal level_5
var sudah_level_5 := false
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	new_phase = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_game_aktif:
		return
	time += delta
	
	_update_phase()
	
func _update_phase():
	
	if time >= 240:
		new_phase = 5
	elif time >= 180:
		new_phase = 4
	elif time >= 120:
		new_phase = 3
	elif  time >= 60:
		new_phase = 2
	if new_phase != phase_sekarang:
		phase_sekarang = new_phase
		phase_changed.emit(new_phase)
		
func _get_phase() -> int:
	return phase_sekarang
	
	
	
func get_time_left() -> float:
	var batas = [60, 120, 180, 240]
	if phase_sekarang <= 4:
		return batas[phase_sekarang - 1] - time
	return 0.0
func _kalah() -> void:
	time = 0.0
	phase_sekarang = 1
	new_phase = 1
	is_game_aktif = true
	
