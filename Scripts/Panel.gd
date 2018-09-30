extends Panel
var label


func _ready():
	if Puntaje.continues != 0:
		get_node("Label").text = String(Puntaje.continues)
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene(Puntaje.ultimaEscena)
	else:
		get_tree().change_scene("res://Escenas/Menu.tscn")
