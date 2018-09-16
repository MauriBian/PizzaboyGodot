extends KinematicBody2D

export var velocidad = 0
var collision
var sprite
var timer


func _ready():
	sprite = get_node("Sprite")
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 3
	timer.connect("timeout",self,"_on_timer_timeout") 
	timer.start()


func _on_timer_timeout():
	self.queue_free()
	
func _physics_process(delta):
	disparo()
	choque()
	
func disparo():
	collision = move_and_collide(Vector2(velocidad,0))


func cambiarDir():
	velocidad = velocidad * -1
	sprite.flip_h = true
	
func choque():
	if collision != null and collision.collider.get_meta("type") == "Enemigo":
		collision.collider.perdiUnaVida()
		self.queue_free()
	