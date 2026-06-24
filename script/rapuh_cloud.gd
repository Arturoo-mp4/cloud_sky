extends AnimatableBody2D
var speed := 150.0
var move_dir = Vector2.DOWN
var sudah_diinjak := false
var timer_saat_diinjak := 0.0
var batas_waktu_diinjak := 0.7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var velocity = move_dir * speed * delta
	var collision = move_and_collide(velocity)
	if sudah_diinjak:
		timer_saat_diinjak += delta
		print(timer_saat_diinjak)
		if timer_saat_diinjak >= batas_waktu_diinjak:
			print("HARUSNYA ILANG")
			queue_free()
	if position.y >= 600:
		queue_free() 
	if PhaseManager.new_phase == 5:
		queue_free()




func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	sudah_diinjak = true
