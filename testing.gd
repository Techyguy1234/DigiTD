extends Node2D

func _ready() -> void:
	$World.generate_new_world(randi(),512)
