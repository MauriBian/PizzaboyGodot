extends KinematicBody2D

export var gravedad = 0
var raycast
export var velMov = 0
var sprite
export var vida = 0
var collision
export var list = []
var padre
var raycast2

func _ready():
	raycast2 = get_node("RayCast2D2")
	padre = get_parent()
	set_meta("type","Enemigo")
	raycast = get_node("RayCast2D")
	sprite = get_node("AnimatedSprite")

func _physics_process(delta):
	personajeCerca(delta,raycast,-1,false)
	personajeCerca(delta,raycast2,2,true)
	gravedad()
	

func _process(delta):
	pass
	
func personajeCerca(delta,ray, dir,flip):
	if ray.is_colliding() and  ray.get_collider() != null and ray.get_collider().name == "Personaje":
		colisionConPersonaje(move_and_collide(Vector2(dir * velMov,0)))
		sprite.play("Caminando")
		sprite.flip_h = flip
	

func colisionConPersonaje(elPj):
	if collision != null and collision.collider.name == "Personaje":
		collision = elPj
		golpieEnemigo(collision.collider)
		
func gravedad():
	collision = move_and_collide(Vector2(0,gravedad))
	
		
func golpieEnemigo(collider):
	collider.pierdoUnaVida()
	
func puedoDropearItem():
	if int(rand_range(1,5)) == 2:
		var scene_instance = list [0] 
		scene_instance = scene_instance.instance()
		scene_instance.set_name("Moneda")
		padre.add_child(scene_instance)
		scene_instance.translate(Vector2(self.position))
		
	
func perdiUnaVida():
	vida -= 1
	if vida == 0:
		padre.sumarPuntaje(100)
		puedoDropearItem()
		self.queue_free()