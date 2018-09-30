extends Button

func _ready():

	pass

func _pressed():
	Puntaje.resetPuntos()
	get_tree().change_scene("res://Escenas/Nivel.tscn")

