extends KinematicBody2D

var sprites
export var velocidadMovimiento = 0
export var salto = 0
func _ready():
	sprites = get_node("AnimatedSprite")
	sprites.play("Normal")

func _process(delta):
	Movimiento()
	Salto()
	
func Movimiento():
	if Input.is_action_pressed("ui_right"):
		sprites.flip_h = false
		sprites.play("Caminando")
		move_and_slide(Vector2(velocidadMovimiento,0))
	elif Input.is_action_pressed("ui_left"):
		sprites.flip_h = true
		sprites.play("Caminando")
		move_and_slide(Vector2(-velocidadMovimiento,0))
	else:
		sprites.play("Normal")

func Salto():
	if Input.is_key_pressed(KEY_SPACE):
		move_and_slide(Vector2(0, -salto))
		sprites.play("Salto")
	




	
	