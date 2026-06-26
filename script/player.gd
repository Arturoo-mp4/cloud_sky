extends CharacterBody2D
@onready var animasi: AnimatedSprite2D = $AnimatedSprite2D
var angin := 0.0
const SPEED = 800.0
const JUMP_VELOCITY = -1000.0
var posisi_collision := 0
var is_attacking := false
var max_hp := 100.0
var current_hp := 100.0
var hp_sebelumnnya := 100.0
var timer_regen := 0.0
var sedang_didamage := false
@onready var hitbox: Area2D = $hitbox
@onready var progress_bar_player: ProgressBar = $"../CanvasLayer/ProgressBarPlayer"
@onready var sword_slash: AudioStreamPlayer2D = $"DaviddumaisaudioSwordSlashAndSwing185432(1)"
@onready var hard_heavy_impact: AudioStreamPlayer2D = $DragonStudioHardHeavyImpact515256






@onready var camera_2d: Camera2D = $Camera2D



func _ready() -> void:
	if PhaseManager.sudah_level_5:
		progress_bar_player.value = current_hp
		progress_bar_player.max_value = max_hp
	hitbox.monitoring = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	
	if current_hp < hp_sebelumnnya:
		hp_sebelumnnya = current_hp
		sedang_didamage = true
		timer_regen = 0
	if sedang_didamage:
		timer_regen += delta
		if timer_regen >= 2:
			timer_regen = 0
			current_hp += 3
			hp_sebelumnnya = current_hp
			progress_bar_player.value = current_hp
			if current_hp >= max_hp:
				current_hp = max_hp
				sedang_didamage = false
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if current_hp <= 0:
		PhaseManager.level_5.emit()
	
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if Input.is_action_pressed("attack"):
		sword_slash.play()
		animasi.play("attack")
		
	elif Input.is_action_pressed("maju_kanann"):
		velocity.x = SPEED * 1 
		animasi.play("walk")
		animasi.flip_h = false
		hitbox.position =Vector2(22, 1)
	elif  Input.is_action_pressed("maju_kiri"):
		velocity.x = SPEED * -1
		animasi.play("walk")
		animasi.flip_h = true
		hitbox.position =Vector2(-72, 1)
	
	
	else:
		velocity.x = move_toward(velocity.x, angin, SPEED)
		animasi.play("default")
	move_and_slide()
	

	
func take_damage(amount: int):
	hard_heavy_impact.play()
	current_hp -= amount
	progress_bar_player.value = current_hp
	
	camera_2d.add_trauma(1)
	
func _on_animated_sprite_2d_frame_changed() -> void:
	
	if animasi.animation == "attack" and animasi.frame == 0:
		
		hitbox.monitoring = true
	else:
		hitbox.monitoring = false



#memberi damage
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "HurtBox":
		var damage = randf_range(3,9)
		area.get_parent().take_damage(damage)
