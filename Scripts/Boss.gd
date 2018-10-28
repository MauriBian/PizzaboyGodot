extends KinematicBody2D
var collision
export var gravedad = 0
export var vida = 0
var padre
var animacion
export var velocidad = 0
var area
var normal
var saltando
var cambiarDir = false
var contador = 0
var siguiente = 1
var gameManager
var saltoRestante = 0
export var salto = 0
var puedoSaltar = true
var animacionWilly
var estoyEnElAire = false
func _ready():
	gameManager = get_parent()
	siguiente = 1
	normal = get_node("Normal")
	saltando = get_node("Willy")
	area = get_node("Area2D")
	area.connect("body_entered",self,"golpieEnemigo")
	animacion = get_node("AnimacionNormal")
	animacionWilly= get_node("AnimacionWilly")
	animacion.play("Andando")
	set_meta("type","Enemigo")
	padre = get_parent()
	print(self.get_meta("type"))
	yield(get_tree().create_timer(4),"timeout")	

		
func _physics_process(delta):
	contador += 1 * delta
	gravedad()
	Rutina(1)
	caer(delta)

func _process(delta):
	if !animacion.is_playing():
		animacion.play("Andando")
		

func gravedad():
	collision = move_and_collide(Vector2(0,gravedad - saltoRestante))

func Saltar(flip):
	if puedoSaltar:
		puedoSaltar = false
		saltando.visible = true
		normal.visible = false
		animacionWilly.play("Animacion")
		saltoRestante = salto
		saltando.flip_h = flip
		estoyEnElAire = true
		
	
func caer(delta):
	if saltoRestante > 0:
		saltoRestante -= (gravedad + salto)/2  * delta
	if saltoRestante < 0:
		saltando.visible = false
		normal.visible = true
		estoyEnElAire = false
		
			
func Rutina(dir):
#El mejor codigo nunca antes visto
	if contador > 0 and contador < 2:
		Movimiento(-dir,velocidad)
		normal.flip_h = true
	if contador > 2 and contador < 4:
		Movimiento(dir,velocidad)
		normal.flip_h = false
	if contador > 4 and contador < 6 :
		Movimiento(-dir,velocidad)
		Saltar(true)
	if contador > 6 and contador < 8:
		Movimiento(dir,velocidad)
		normal.flip_h = false
		puedoSaltar = true
	if contador > 8 and contador < 9.5:
		Movimiento(-dir,velocidad)
		normal.flip_h = true
	if contador > 9.5 and contador < 11:
		Movimiento(dir,velocidad)
		Saltar(false)
	if contador > 11:
		contador = 0
		puedoSaltar = true
	
		
func Movimiento(dir,velocidad):
	collision = move_and_collide(Vector2(dir* velocidad,0))
		
func golpieEnemigo(target):
	if target.name == "Personaje":
		target.pierdoUnaVida()
	if target.get_meta("type") == "Bala":
		perdiUnaVida()
		target.queue_free()

func perdiUnaVida():
	if !estoyEnElAire:
		animacion.play("Dañado")
	else:
		animacionWilly.play("Dañado")
	vida -= 1
	if vida == 0:
		padre.sumarPuntaje(100)
		self.queue_free()