extends RayCast2D

@onready var player := $Player  # Referência ao nó do jogador ou outro objeto relevante

# Called when the node enters the scene tree for the first time.
func _ready():
	# Ativa o RayCast2D, garantindo que ele esteja visível para fins de debug.
	self.enabled = true

	# Se quiser visualizar o raycast, pode ativar o debug.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Verifica se o raio está colidindo com algo
	if is_colliding():
		var collision_point = get_collision_point()  # Pega o ponto de colisão
		var collider = get_collider()  # Pega o objeto com o qual colidiu
		
		# Realiza alguma ação baseada na colisão (exemplo: aplicar dano ou efeito)
		if collider:
			print("Colidiu com: ", collider.name)
			# Aqui, você pode adicionar lógica para o que acontece ao colidir com algo, por exemplo:
			# - Reduzir vida
			# - Detonar o personagem
			# - Executar uma animação
			if collider.is_in_group("enemies"):
				# Supondo que o jogador ou personagem tenha uma função take_damage
				get_tree().change_scene_to_file("res://game_over.tscn")
				Global.mortes += 1
