extends Node2D
@export var player_scene : PackedScene
@onready var defeat_screen: CanvasLayer = $Defeat_Screen
@onready var key: Area2D = $key
@onready var portal: Area2D = $portal
@onready var label: Label = $Label
var player_tewas := false
var kunci := false

@onready var boss: CharacterBody2D = $boss

@onready var collision_portal: CollisionShape2D = $portal/CollisionShape2D
@onready var collision_key: CollisionShape2D = $key/CollisionShape2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	key.monitoring = false
	portal.monitoring = false
	PhaseManager.sudah_level_5 = true
	key.hide()
	portal.hide()
	boss_mati.boss_tewas.connect(bos_die)
	PhaseManager.level_5.connect(player_mati)
	defeat_screen.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func level_5():
	defeat_screen.show()



func bos_die():
	key.monitoring = true
	portal.monitoring = true
	key.show()
	
	portal.show()
func player_mati():
	player_tewas = true
	defeat_screen.show()


func _on_key_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		
		kunci = true
		key.queue_free()


func _on_portal_body_entered(body:CharacterBody2D) -> void:
	if kunci:
		get_tree().change_scene_to_file("res://scene/canvas_layer.tscn")


func _on_button_pressed() -> void:
	
	print("jahd")
	if boss.direction > 0:
		boss.position.x -= 500
	else:
		boss.position.x += 500
