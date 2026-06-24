extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var platform: StaticBody2D = $Platform

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	print("Level 5!")
	get_tree().change_scene_to_file("res://scene/boss_map.tscn")
