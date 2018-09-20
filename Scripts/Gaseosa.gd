extends StaticBody2D
var timer
var animacion
var sprite
var gameManager
export(PackedScene) var bala
export var vida = 0
export var list = []
func _ready():
	self.set_meta("type","Enemigo")
	timer = Timer.new()
	timer.wait_time = 2
	add_child(timer)
	timer.connect("timeout",self,"disparo")
	sprite = get_node("Sprite")
	animacion = get_node("Sprite/AnimationPlayer")
	gameManager = get_parent()
	timer.start()
	
func disparo():
	animacion.play("Disparo")
	if sprite.frame > 1:
		var scene_instance = bala
		scene_instance = scene_instance.instance()
		scene_instance.set_name("Bala")
		gameManager.add_child(scene_instance)
		scene_instance.translate(Vector2(self.position.x - 50 ,self.position.y -20))
		
func golpieEnemigo(collider):
	collider.pierdoUnaVida()

func perdiUnaVida():
	print(vida)
	vida -= 1
	if vida == 0:
		gameManager.sumarPuntaje(200)
		puedoDropearItem()
		self.queue_free()
		
func puedoDropearItem():
	if int(rand_range(1,5)) == 2:
		var scene_instance = list [0] 
		scene_instance = scene_instance.instance()
		scene_instance.set_name("Moneda")
		gameManager.add_child(scene_instance)
		scene_instance.translate(Vector2(self.position))
