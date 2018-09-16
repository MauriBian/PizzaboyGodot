extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_meta("type","Moneda")
	connect("body_entered",self,"agarrarMoneda")
	
func agarrarMoneda(target):
	if target.name == "Personaje":
		target.monedas += 1
		self.queue_free()
		print(target.monedas)
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
