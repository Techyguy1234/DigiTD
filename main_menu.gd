extends Control

func _ready() -> void:
	$World.generate_new_world(1357,256)
	$World2.generate_new_world(2468,256)
	$AnimationPlayer.play("World Menu")
