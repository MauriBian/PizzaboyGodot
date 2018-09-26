extends KinematicBody2D
var collision
export var gravedad = 0
export var vida = 0
var padre
var animacion
export var velocidad = 0
var area
var sprite
var cambiarDir = false
var timer 
func _ready():
	sprite = get_node("Sprite")
	area = get_node("Area2D")
	area.connect("body_entered",self,"golpieEnemigo")
	animacion = get_node("AnimationPlayer")
	animacion.play("Andando")
	set_meta("type","Enemigo")
	padre = get_parent()
	print(self.get_meta("type"))
	yield(get_tree().create_timer(4),"timeout")

	

func _physics_process(delta):
	gravedad()
	
	
	
func _process(delta):
	
	if !animacion.is_playing():
		animacion.play("Andando")
		

func gravedad():
	collision = move_and_collide(Vector2(0,gravedad))



	
func Movimiento(dir,flip):
	collision = move_and_collide(Vector2(dir * velocidad,0))
	sprite.flip_h = flip
	

		
		
		
func golpieEnemigo(target):
	if target.name == "Personaje":
		target.pierdoUnaVida()

func perdiUnaVida():
	animacion.play("Dañado")

	vida -= 1
	if vida == 0:
		padre.sumarPuntaje(100)
		self.queue_free()