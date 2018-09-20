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
var apreteSaltar = false
export var vida = 0
var timer
var puedoDisparar = true
var monedas = 0
func _ready():
	
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.connect("timeout",self,"rafaga")
	self.set_meta("type","Personaje")
	velocidad = velocidadMovimiento
	sprites = get_node("AnimatedSprite")
	sprites.play("Normal")
	gameManager = get_parent()
	
func Movimiento(delta):
	if Input.is_action_pressed("ui_right"):
		sprites.flip_h = false
		correr(delta)
		collision = move_and_collide(Vector2(velocidad,0))
	elif Input.is_action_pressed("ui_left"):
		sprites.flip_h = true
		correr(delta)
		collision = move_and_collide(Vector2(-velocidad,0))
	elif !puedoSaltar and !apreteSaltar:
		sprites.play("Cayendo")
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
	puedoSaltar()
	ToqueEnemigo()
	
func rafaga():
	puedoDisparar = true

func monedas():
	gameManager.sumarMonedas(monedas) 

func correr(delta):
	if distanciaRecorrida > 2:
		AnimarSiNoEstoyEnElAire("Corriendo")
		velocidad = velocidadExtra
	else:
		AnimarSiNoEstoyEnElAire("Caminando")
		distanciaRecorrida += 1 * delta

func Salto():
	if Input.is_action_just_pressed("ui_up") and puedoSaltar:
		apreteSaltar = true
		fuerzaSaltoRestante = salto
		puedoSaltar = false
		sprites.play("Salto")
		
func ToqueEnemigo():
	if collision != null and collision.collider.get_meta("type") == "Enemigo":
		collision.collider.golpieEnemigo(self)

func pierdoUnaVida():
	vida -= 1
	if vida == 0:
		print("uf")
		self.queue_free()
	
	
func caer(delta):
	if fuerzaSaltoRestante > 0:
		fuerzaSaltoRestante -= (gravedad + salto)/2  * delta

func puedoSaltar():
	if collision != null and collision.collider.get_meta("type") == "Piso" :
		puedoSaltar = true
		apreteSaltar = false
	else:
		puedoSaltar = false

func gravedad():
	collision = move_and_collide(Vector2(0,gravedad - fuerzaSaltoRestante))
	

func AnimarSiNoEstoyEnElAire(animacion):
	if collision != null and collision.collider.get_meta("type") == "Piso" :
		sprites.play(animacion)
		


		
func Disparo():
	if Input.is_action_just_pressed("ui_accept") and puedoDisparar:
		puedoDisparar = false
		timer.start()
		salirDelIdle()
		var scene_instance = bala
		scene_instance = scene_instance.instance()
		scene_instance.set_name("Bala")
		gameManager.add_child(scene_instance)
		scene_instance.translate(Vector2(self.position.x + estoyFlipando(30,scene_instance) ,self.position.y + 5))

	



	
func estoyFlipando(numero,bala):
	if sprites.flip_h:
		bala.cambiarDir(true)
		return -numero
	else:
		return numero
		
func salirDelIdle():
	if sprites.frame >= 12:
		sprites.frame = 0

	

		
	