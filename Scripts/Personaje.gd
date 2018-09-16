extends KinematicBody2D

var sprites
export var velocidadMovimiento = 0
export var salto = 0
var fuerzaSaltoRestante = 0
export var velocidadExtra = 0
var velocidad
export var gravedad = 10
var collision
var distanciaRecorrida = 0
var estoyIdle = false
export(PackedScene) var  bala
var gameManager
var puedoSaltar = true
export var vida = 0

func _ready():
	self.set_meta("type","Personaje")
	velocidad = velocidadMovimiento
	sprites = get_node("AnimatedSprite")
	sprites.play("Normal")
	gameManager = get_parent()
	
func Movimiento(delta):
	if Input.is_action_pressed("ui_right"):
		sprites.flip_h = false
		correr(delta)
		collision = move_and_collide(Vector2(velocidadMovimiento,0))
	elif Input.is_action_pressed("ui_left"):
		sprites.flip_h = true
		correr(delta)
		collision = move_and_collide(Vector2(-velocidadMovimiento,0))
	else:
		AnimarSiNoEstoyEnElAire("Normal")
		distanciaRecorrida = 0
		velocidad = velocidadMovimiento
	
	
func _physics_process(delta):	
	Movimiento(delta)
	Salto()
	caer(delta)
	gravedad()
	
	
func _process(delta):
	Disparo()

	
func correr(delta):
	if distanciaRecorrida > 2:
		AnimarSiNoEstoyEnElAire("Corriendo")
		velocidad = velocidadExtra
	else:
		AnimarSiNoEstoyEnElAire("Caminando")
		distanciaRecorrida += 1 * delta

func Salto():
	if Input.is_action_pressed("ui_up") and puedoSaltar:
		fuerzaSaltoRestante = salto
		puedoSaltar = false

func pierdoUnaVida():
	vida -= 1
	
func caer(delta):
	if fuerzaSaltoRestante > 0:
		fuerzaSaltoRestante -= (gravedad + salto)/2  * delta
		

func gravedad():
	collision = move_and_collide(Vector2(0,gravedad - fuerzaSaltoRestante))

func AnimarSiNoEstoyEnElAire(animacion):
	if collision != null and collision.collider.get_meta("type") == "Piso" :
		sprites.play(animacion)
		puedoSaltar = true


		
func Disparo():
	if Input.is_action_just_pressed("ui_accept"):
		salirDelIdle()
		var scene_instance = bala
		scene_instance = scene_instance.instance()
		scene_instance.set_name("Bala")
		gameManager.add_child(scene_instance)
		scene_instance.translate(Vector2(self.position.x + estoyFlipando(30,scene_instance) ,self.position.y + 5))

	
func estoyFlipando(numero,bala):
	if sprites.flip_h:
		bala.cambiarDir()
		return -numero
	else:
		return numero
		
func salirDelIdle():
	if sprites.frame >= 12:
		sprites.frame = 0

	

		
	