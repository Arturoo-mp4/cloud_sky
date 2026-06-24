extends Node2D
var speed := 500
var target_dir := Vector2.DOWN
var durasi := 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += target_dir * speed * delta
	durasi += delta
	if durasi >= 4:
		queue_free()


func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.take_damage(10)
		
