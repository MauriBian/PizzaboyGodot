extends Node2D
var puntaje
var puntajeText
var monedasText

func _ready():
	puntaje = 0
	puntajeText = get_node("CanvasLayer/Puntaje")
	monedasText = get_node("CanvasLayer/Salames")

func _process(delta):
	pass
	
func sumarPuntaje(suma):
	puntaje += suma
	puntajeText.text = String(puntaje )
	
func sumarMonedas(monedas):
	monedasText.text = String(monedas)
