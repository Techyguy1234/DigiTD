extends Control

func _ready() -> void:
	$World.generate_new_world(randi(),256)
	$World2.generate_new_world(randi(),256)
	$AnimationPlayer.play("World Menu")
