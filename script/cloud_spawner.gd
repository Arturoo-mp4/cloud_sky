extends Node2D
@export var cloud_scene : PackedScene
@export var cloud_giant_scene: PackedScene
@export var cloud_rapuh_scene : PackedScene
var screen_size : Vector2
var spawn_timer := 0.0
var timer_jeda := 0.5
var cloud_speed := 150.0

var spawn_timer_giant := 0.0
var jeda_giant := 1.0

var spawn_timer_rapuh := 0.0
var jeda_rapuh := 0.8

const batas_kanan := 895
const batas_kiri := -batas_kanan
const spawn_atas := -670

const spawn_kiri_giant := -643.0
const spawn_kanan_giant := 643.0

var sudah_level_5 := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	PhaseManager.phase_changed.connect(_on_phase_changed)
	sudah_level_5 = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer += delta
	if spawn_timer >= timer_jeda:
		spawn_timer = 0.0
		_spawn_next()
	if not PhaseManager.is_game_aktif:
		return
	if PhaseManager.phase_sekarang >= 3:
		spawn_timer_giant += delta
		if spawn_timer_giant >= jeda_giant:
			spawn_timer_giant = 0 
			_spawn_giant_cloud()
	if PhaseManager.phase_sekarang >= 4:
		spawn_timer_rapuh += delta
		if spawn_timer_rapuh >= jeda_rapuh:
			spawn_timer_rapuh = 0
			_spawn_rapuh_cloud()
	if PhaseManager.phase_sekarang >= 5:
		sudah_level_5 = true
	
		
func _spawn_next():
	if sudah_level_5:
		return
	else:
		var x = randf_range(batas_kiri, batas_kanan)
		spawn_cloud_at(x, spawn_atas)
	

func spawn_cloud_at(x: float, y: float):
	var cloud = cloud_scene.instantiate()
	cloud.position = Vector2(x,y)
	cloud.speed = cloud_speed
	add_child(cloud)
	if PhaseManager.phase_sekarang >= 2:
		cloud.gerak_horizontal = true
		cloud.phase_2 = true
		cloud.arah_horizontal = [1.0, -1.0].pick_random()

	

	
func _on_phase_changed(new_phase: int):
	match  new_phase:
		2:
			cloud_speed = 150
			timer_jeda = 0.4
		3:
			cloud_speed = 300
			timer_jeda = 0.4
		4:
			cloud_speed = 400
			timer_jeda = 0.5
		5:
			PhaseManager.is_game_aktif = false

func _spawn_giant_cloud() -> void:
	#print("giantcloud spawn")
	var cloud_giant = cloud_giant_scene.instantiate()
#	print("giant cloud posisi: ", cloud_giant.position)
	var dari_kiri := randi() % 2 == 0
	if dari_kiri:
		cloud_giant.position = Vector2(spawn_kiri_giant, _random_y_arena())
		cloud_giant.arah_horizontal = 1
	else:
		cloud_giant.position = Vector2(spawn_kanan_giant, _random_y_arena())
		cloud_giant.arah_horizontal = -1
	add_child(cloud_giant)
#	print("giant cloud di posisi: ", cloud_giant.position)
		
func _random_y_arena() -> float:
	return randf_range(-400, 400)
	
func _spawn_rapuh_cloud():
	var cloud_rapuh = cloud_rapuh_scene.instantiate()
	var x = randf_range(-854, 854)
	cloud_rapuh.position = Vector2(x, -603)
	add_child(cloud_rapuh)
