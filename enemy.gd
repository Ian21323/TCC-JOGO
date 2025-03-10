extends CharacterBody2D

const SPEED = 1050.0
const JUMP_VELOCITY = -400

@onready var wall_detector := $wall_detector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer
var direction := -1

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Função chamada a cada frame de física
func _physics_process(delta: float) -> void:
	# Aplica a gravidade se o personagem não estiver no chão
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Verifica colisão com a parede e inverte a direção
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
	
	# Altera a direção do personagem
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
	
	# Move o personagem
	velocity.x = direction * SPEED * delta
	move_and_slide()

# Função chamada quando o inimigo termina de ser atingido
func _on_hurt_finish() -> void:
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
			game_manager.incrementar_inimigo()  # Incrementa a contagem de inimigos
	
	# Remove o inimigo da cena
	queue_free()  # Remove o inimigo da cena
