func _on_body_entered(body):
	# Verifica se o corpo que entrou é o jogador
	if body.name == "Player":
		print("Player in")
		get_tree().change_scene_to_file("res://word_02.tscn")
