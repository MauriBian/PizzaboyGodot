extends KinematicBody2D

export var velocidad = 0
var collision
var sprite
var timer
export var soyBalaEnemiga = false
export(float) var tiempoDeVida = 0
export var soyBoss = false

func _ready():
	set_meta("type","Bala")
	sprite = get_node("Sprite")
	balaEnemiga()
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = tiempoDeVida
	timer.connect("timeout",self,"_on_timer_timeout") 
	timer.start()


func _on_timer_timeout():
	self.queue_free()
	
func _physics_process(delta):
	disparo()
	choque()

func disparo():
	collision = move_and_collide(Vector2(velocidad,0))


func cambiarDir(flip):
	velocidad = velocidad * -1
	sprite.flip_h = flip
	
func choque():
	if collision != null and collision.collider.get_meta("type") == "Enemigo" and !soyBalaEnemiga:
		collision.collider.perdiUnaVida()
		self.queue_free()
		
	elif collision != null and collision.collider.name == "Personaje" and soyBalaEnemiga:
		collision.collider.pierdoUnaVida()

	elif collision != null:
		queue_free()

func balaEnemiga():
	if soyBalaEnemiga and !soyBoss:
		cambiarDir(false)