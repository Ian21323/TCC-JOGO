extends Node2D

# Referências aos labels
@onready var moedas_label = get_node("CanvasLayer/MoedasLabel")
@onready var inimigos_label = get_node("CanvasLayer/InimigosLabel")
@onready var mortes_label = get_node("CanvasLayer/MortesLabel")

# Função para incrementar a contagem de moedas
func incrementar_moeda():
	Global.moedas += 1  # Atualiza a variável global
	_atualizar_moedas_label()

# Função para incrementar a contagem de inimigos
func incrementar_inimigo():
	Global.inimigos += 1  # Atualiza a variável global
	_atualizar_inimigos_label()

# Função para incrementar a contagem de mortes
func incrementar_mortes():
	Global.mortes += 1  # Atualiza a variável global
	_atualizar_mortes_label()

# Função para atualizar o texto do label de moedas
func _atualizar_moedas_label():
	if moedas_label:
		moedas_label.text = "  Moedas: " + str(Global.moedas)

# Função para atualizar o texto do label de inimigos
func _atualizar_inimigos_label():
	if inimigos_label:
		inimigos_label.text = "Inimigos: " + str(Global.inimigos)

# Função para atualizar o texto do label de mortes
func _atualizar_mortes_label():
	if mortes_label:
		mortes_label.text = "Mortes: " + str(Global.mortes)

# Inicializa os labels no _ready e ajusta a posição
func _ready():
	# Configura o texto inicial com os valores glxobais
	_atualizar_moedas_label()
	_atualizar_inimigos_label()
	_atualizar_mortes_label()

	# Ajusta a posição para evitar sobreposição
	if moedas_label:
		moedas_label.position = Vector2(10, 10)  # Posição para o MoedasLabel
	if inimigos_label:
		inimigos_label.position = Vector2(10, 40)  # Posição abaixo do MoedasLabel
	if mortes_label:
		mortes_label.position = Vector2(10, 70)  # Posição abaixo do InimigosLabel
