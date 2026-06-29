extends Node2D
var arah_angin := 1.0
var durasi_angin := 0.0
var timer_angin := 0.0
var angin_aktif := false
var fase_sekarang := 0

@onready var label: Label = $CanvasLayer/Label

@onready var angin_lvl_4: AudioStreamPlayer2D = $"../angin_lvl4"



@export var player : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PhaseManager.phase_changed.connect(wind_aktif)
	angin_aktif = false
	label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	print("halo")
	if fase_sekarang != 4:
		return
	else:
		
		if not angin_aktif:
			label.visible = false
			timer_angin += delta
			player.angin = 0.0
			print("cooldown angin: ", timer_angin)
			if timer_angin >= 5:
				angin_aktif = true
				arah_angin = [1.0, -1.0].pick_random()
				timer_angin = 0
				player.angin = 0.0
				
		if angin_aktif:
			
			label.visible = true
			angin_lvl_4.play()
			durasi_angin += delta
			print("angin durasi: ", int(durasi_angin) )
			player.angin  += 2 * arah_angin
			if durasi_angin >= 2:
				durasi_angin = 0 
				angin_aktif = false
				print("angin sudah mati ")
			
		
func wind_aktif(new_phase: int) -> void:
	fase_sekarang = new_phase
	
