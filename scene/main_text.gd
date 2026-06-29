extends CanvasLayer
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PhaseManager.new_phase >= 2:
		label.text = "Cloud now can move horizontaly!"
	if PhaseManager.new_phase >= 3:
		label.text = "Be carefull with the Giant CLoud!"
	if PhaseManager.new_phase >= 4:
		label.text = "Adding a Fragile Cloud and the wind sometime will pushes you!"
	if PhaseManager.new_phase >= 5:
		label.text = "Enter the portal and to fight the boss!!"
