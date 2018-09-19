extends KinematicBody2D

export var gravedad = 0
var raycast
export var velMov = 0
var sprite
export var vida = 0
var collision
export var list = []
var padre

func _ready():
	padre = get_parent()
	set_meta("type","Enemigo")
	raycast = get_node("RayCast2D")
	sprite = get_node("AnimatedSprite")


func _physics_process(delta):
	personajeCerca(delta)
	gravedad()
	

func _process(delta):
	pass
	
func personajeCerca(delta):
	if raycast.get_collider() != null and raycast.get_collider().name == "Personaje":
		buscarAlPersonaje(move_and_collide(Vector2(-velMov,0)))
		sprite.play("Caminando")
		

func gravedad():
	collision = move_and_collide(Vector2(0,gravedad))

func buscarAlPersonaje(choque):
	if collision != null and collision.collider.get_meta("type") == "Personaje":
		collision = choque
		golpieEnemigo(collision.collider)
		
func golpieEnemigo(collider):
	collider.pierdoUnaVida()
	
func puedoDropearItem():
	if int(rand_range(2,4)) == 2:
		var scene_instance = list [0] 
		scene_instance = scene_instance.instance()
		scene_instance.set_name("Moneda")
		padre.add_child(scene_instance)
		scene_instance.translate(Vector2(self.position))
		
	
func perdiUnaVida():
	vida -= 1
	if vida == 0:
		puedoDropearItem()
		self.queue_free()