extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var player_life := 10
var knockback_vector := Vector2.ZERO

@onready var animation := $anim as AnimatedSprite2D
@onready var hurtbox := $hurtbox as Area2D  # Area2D para detectar colisões com inimigos
@onready var jum_bg = $jum_bg as AudioStreamPlayer

# Função chamada quando o jogador colide com um inimigo (via Area2D)
func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):  # Verifica se é um inimigo
		take_damage(Vector2(-200, -200), 0.5)  # Aplica dano e knockback

# Aplica dano e efeitos de knockback
func take_damage(knockback_force: Vector2 = Vector2.ZERO, duration: float = 0.25) -> void:
	player_life -= 1
	if player_life <= 0:
		queue_free()  # Remove o jogador da cena (morte)
	
	# Verifica se há knockback a ser aplicado
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		# Cria o Tween para animar o movimento de knockback
		var knockback_tween = get_tree().create_tween()
		
		# Aplique o knockback na direção desejada
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		
		# Impede que o jogador se mova enquanto o knockback está ativo
		velocity = knockback_vector
		# Você pode também adicionar um timer ou um método que permite retornar ao controle após o knockback.
	
# Controle do movimento do jogador
func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if is_on_floor():
		is_jumping = false
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			is_jumping = true
			jum_bg.play()

	# Handle horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")

	if is_jumping:
		if direction != 0:
			animation.scale.x = direction
			velocity.x = direction * SPEED
		else:
			velocity.x = 0  # Stop horizontal movement if no input is provided while jumping.
		animation.play("jump")
	elif direction != 0:
		animation.scale.x = direction
		velocity.x = direction * SPEED
		animation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")

	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector

	# Apply movement and slide
	move_and_slide()
