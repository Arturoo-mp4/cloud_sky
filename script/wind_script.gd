extends Node2D
var arah_angin := 1.0
var durasi_angin := 0.0
var timer_angin := 0.0
var angin_aktif := false
var fase_sekarang := 0

@export var player : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PhaseManager.phase_changed.connect(wind_aktif)
	angin_aktif = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fase_sekarang != 4:
		return
	else:
		if not angin_aktif:
			
			timer_angin += delta
			player.angin = 0.0
			print("cooldown angin: ", timer_angin)
			if timer_angin >= 5:
				angin_aktif = true
				arah_angin = [1.0, -1.0].pick_random()
				timer_angin = 0
				player.angin = 0.0
				
		if angin_aktif:
			
			durasi_angin += delta
			print("angin durasi: ", durasi_angin )
			player.angin  += 1 * arah_angin
			if durasi_angin >= 2:
				durasi_angin = 0 
				angin_aktif = false
				print("angin sudah mati ")
			
		
func wind_aktif(new_phase: int) -> void:
	fase_sekarang = new_phase
	
