extends CharacterBody2D
@onready var animasi: AnimatedSprite2D = $AnimatedSprite2D

@onready var camera_2d: Camera2D = $"../Player/Camera2D"
@export var cloud_scene : PackedScene
@export var gc_cloud_scene : PackedScene

var shoot_timer := 0.0
var jeda_shoot := 5.0

var bos_tewas := false
var max_hp := 100.0
var current_hp := 100.0
var hp_sebelumnya := 100.0
var timer_regen := 0.0
var sedang_dihit := false
var is_phase2 := false
var rage := false

#collision
@onready var hit_box: Area2D = $Hit_Box
@onready var hurt_box: Area2D = $HurtBox
@onready var fisik_box: CollisionShape2D = $CollisionShape2D






var gc_shoot_timer := 0.0

var sedang_attack := false

@onready var progress_bar_boss: ProgressBar = $"../CanvasLayer/ProgressBarBoss"



var direction := 0.0
var jarak := 0.0
var SPEED = 400.0
const JUMP_VELOCITY = -400.0
var is_attack := false
var player = null
var player_masuk := false

signal lagi_attack

func _ready() -> void:
	
	hit_box.monitoring = false
	progress_bar_boss.value = current_hp
	progress_bar_boss.max_value = max_hp
	

func _physics_process(delta: float) -> void:
	if bos_tewas:
		return
	if rage:
		return
	# Add the gravity.
	if is_phase2:
		gc_shoot_timer += delta
		if gc_shoot_timer >= 5:
			var random_x = randf_range(-875, 950)
			spawn_gc_cloud_at(random_x, -1000)
		
			
			
	if current_hp < hp_sebelumnya:
		hp_sebelumnya = current_hp
		timer_regen = 0
		sedang_dihit = true
		
	if sedang_dihit:
		timer_regen += delta
		if timer_regen >= 5:
			timer_regen = 0
			current_hp += 5
			progress_bar_boss.value = current_hp
			hp_sebelumnya = current_hp
			if current_hp >= max_hp:
				sedang_dihit = false
	
	
	
	
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not player_masuk:
		return
	elif player_masuk:
		direction  = sign(player.global_position.x - global_position.x)
		jarak = abs(player.global_position.x - global_position.x)
		if jarak > 10.0:
			velocity.x = direction * SPEED
		else:
			velocity.x = 0
	move_and_slide()
	if jarak:
		#if is_attack:
			#return
		#lagi_attack.emit()
		animasi_jalan()
	if current_hp <= 0  and not bos_tewas:
		die()
		
	shoot_timer += delta
	if shoot_timer >= jeda_shoot:
		shoot_player()
		
		
	if not is_phase2 and current_hp <= max_hp * 0.5:
		masuk_fase2()
		
	
func masuk_fase2():
	animasi.play("rage")
	animasi.modulate = Color.from_hsv(0.0, 1.0, 0.7, 1.0)
	rage = true
	await animasi.animation_finished
	jeda_shoot = 2.0
	rage = false
	
	
	is_phase2 = true
	SPEED = 600
func spawn_gc_cloud_at(x:float, y: float):
	gc_shoot_timer = 0
	var gc_cloud = gc_cloud_scene.instantiate()
	
	
	gc_cloud.position = Vector2(x, y)
	print(gc_cloud.position)
	get_parent().add_child(gc_cloud)

func _on_area_2d_body_entered(body:CharacterBody2D):
	
	if body.name == "Player":
		player = $"../Player"
		player_masuk =true
	
func animasi_jalan():
	if rage:
		return
	
	if jarak >= 120.0:
		
		animasi.play("walk'")
		animasi.flip_h = direction < 0
		if direction < 0:
			print("kiri hurt box.x: ", hurt_box.position.x)
			print("kiri fisik box.x: ", fisik_box.position.x)
			hit_box.position = Vector2(-15, 23)
			fisik_box.position = Vector2(9, fisik_box.position.y)
			hurt_box.position = Vector2(11, hurt_box.position.y)
			
			
		else:
			print("hurt box.x: ", hurt_box.position.x)
			print("fisik box.x: ", fisik_box.position.x)
			hit_box.position = Vector2(15, 23)
			fisik_box.position = Vector2(-9, fisik_box.position.y)
			hurt_box.position = Vector2(11, hurt_box.position.y)
			
			
	else:
		
		attack()
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	animasi.play("idle")
	player_masuk = false
func attack():
	if bos_tewas:
		return
	is_attack = true
	animasi.play("attack 1")
	if animasi.animation == "attack 1" and animasi.frame == 4:
		hit_box.monitoring = true
		sedang_attack = true
		
	await  animasi.animation_finished
	sedang_attack = false
	hit_box.monitoring = false
	animasi.play("attack 2")
	if animasi.animation == "attack 2" and animasi.frame == 3:
		hit_box.monitoring = true
		sedang_attack = true
		
	await animasi.animation_finished
	sedang_attack = false
	hit_box.monitoring = false
	animasi.play("attack 3")
	if animasi.animation == "attack 1" and animasi.frame == 4:
		hit_box.monitoring = true
		sedang_attack = true
		
	await  animasi.animation_finished
	sedang_attack = false
	hit_box.monitoring = false
	is_attack = false
	
	


func take_damage(amount: int):
	current_hp -= amount
	progress_bar_boss.value = current_hp
	print(current_hp)
	
	
func die():
	bos_tewas = true
	animasi.play("death")
	await  animasi.animation_finished
	boss_mati.boss_tewas.emit()
	print("boss mati")
	queue_free()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.name == "hurtboxplayer":
		var random = randf_range(3,8)
		if is_phase2:
			random = randf_range(8,14)
		area.get_parent().take_damage(random)



func shoot_player():
	var cloud = cloud_scene.instantiate()
	cloud.position = global_position + Vector2(0, -80)
	get_parent().add_child(cloud)
	cloud.set("target_dir", (player.global_position - global_position).normalized())
	
	shoot_timer = 0
	
