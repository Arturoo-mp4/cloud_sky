extends Camera2D
var trauma := 0.0
var noise := FastNoiseLite.new()
var noise_t := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise.seed = randi()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	trauma = max(0.0, trauma - 1.5 * delta)
	var shake = trauma * trauma
	noise_t += 5000 * delta
	offset.x = 30 * shake * noise.get_noise_2d(noise_t, 0)
	offset.y = 20 * shake * noise.get_noise_2d(0, noise_t)
func add_trauma(amount: float):
	trauma = min(trauma + amount, 1.0)
