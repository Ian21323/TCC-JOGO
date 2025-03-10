extends Area2D

# Variável para controlar se a moeda foi coletada
var moeda_coletada = false
@onready var coin_sfx = $coin_sfx as AudioStreamPlayer

# Chamado quando o nó entra na árvore de cena pela primeira vez
func _ready():
	pass

# Função chamada quando o player entra em colisão com a moeda
func _on_body_entered(body):
	if not moeda_coletada:
		moeda_coletada = true  # Marca a moeda como coletada
		$anim.play("colect")  # Toca a animação de coleta
		
		# Lista de game_managers
		var game_managers = [
			get_node("/root/word-01"),
			get_node("/root/word-02"),
			get_node("/root/word-03"),
			get_node("/root/word-04")
		]
		
		# Itera sobre a lista de game_managers
		for game_manager in game_managers:
			if game_manager:  # Verifica se o game_manager é válido
				game_manager.incrementar_moeda()  # Chama o método incrementar_moeda

		# Após a animação terminar, remove a moeda da cena
			
		queue_free()  # Remove a moeda da cena após a animação
		
# Função chamada quando a animação termina
func _on_anim_animation_finished():
	pass
