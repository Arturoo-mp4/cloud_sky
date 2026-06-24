extends AnimatableBody2D
var speed := 500
var arah_horizontal := 1
@onready var giant_cloud: AnimatableBody2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sync_to_physics = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var velocity = Vector2(arah_horizontal * speed * delta, 0)
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		if collider is CharacterBody2D:
			collider.velocity.x = arah_horizontal * 800.0
			collider.velocity.y = -980.0
		
		else:
			arah_horizontal *= -1
			move_toward(arah_horizontal * speed, 0,1.0)
	if PhaseManager.new_phase == 5:
		queue_free()
			#collider.velocity.x += 600
	
	if position.x >= 1500 or position.x <= -1500:
		queue_free()
