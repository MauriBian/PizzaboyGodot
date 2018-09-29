extends Area2D



func _ready():

	self.connect("body_entered",self,"cambioDeNivel")

func cambioDeNivel(target):
	get_tree().change_scene("res://Escenas/NivelBoss.tscn")

