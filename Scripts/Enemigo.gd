extends KinematicBody2D

export var gravedad = 0
var raycast
export var velMov = 0
var sprite
export var vida = 0
var raycast2
func _ready():
	set_meta("type","Enemigo")
	raycast = get_node("RayCast2D")
	sprite = get_node("AnimatedSprite")
	raycast2 = get_node("RayCast2D2")


func _physics_process(delta):
	personajeCerca(delta)
	gravedad()

func _process(delta):
	golpieEnemigo()
	
func personajeCerca(delta):
	if raycast.get_collider() != null and raycast.get_collider().get_meta("type") == "Personaje":
		move_and_collide(Vector2(-velMov,0))
		sprite.play("Caminando")
		

func gravedad():
	move_and_collide(Vector2(0,gravedad))

func golpieEnemigo():
	if raycast2.get_collider() != null  and raycast2.get_collider().get_meta("type") == "Personaje": 
		raycast2.get_collider().pierdoUnaVida()
		print("PUNCHhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
		
func perdiUnaVida():
	vida -= 1
	if vida == 0:
		self.queue_free()