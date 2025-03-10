extends Area2D

func _on_body_entered(body):
	print("Player in")
	get_tree().change_scene_to_file("res://word_03.tscn")
	
