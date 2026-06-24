extends AnimatableBody2D
var speed := 150.0
var move_dir = Vector2.DOWN
var gerak_horizontal := false
var phase_2 := false
var arah_horizontal := 1.0






# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
		
	var velocity = move_dir * speed * delta
	if gerak_horizontal:
		velocity.x +=   arah_horizontal * speed  * delta
		
	
	var colision = move_and_collide(velocity)
	if colision:
		var collider = colision.get_collider()
		if collider is  CharacterBody2D:
			pass
		else:
			arah_horizontal *= -1
			
	if PhaseManager.new_phase == 5:
		queue_free()
	
	
	if position.y > 600:
		
		queue_free()
	
	if position.x >= 895 :
		position.x = 894  
		arah_horizontal *= -1
	elif position.x <= -895:
		position.x = -894  
		arah_horizontal *= -1
		
		
		
