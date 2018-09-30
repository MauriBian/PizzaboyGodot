extends Node2D
var puntajeText
var monedasText

func _ready():
	
	puntajeText = get_node("CanvasLayer/Puntaje")
	monedasText = get_node("CanvasLayer/Salames")
	puntajeText.text = String(Puntaje.puntaje)
	monedasText.text = String(Puntaje.salames)
func _process(delta):
	pass
	
func sumarPuntaje(suma):
	Puntaje.puntaje += suma
	puntajeText.text = String(Puntaje.puntaje )
	
func sumarMonedas(monedas):
	Puntaje.salames = monedas
	monedasText.text = String(Puntaje.salames)
