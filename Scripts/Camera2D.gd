extends Camera2D

var gameManager

func _ready():
	gameManager = get_parent()

func _process(delta):
	
	if gameManager.get_node("Personaje") != null:
		self.position = gameManager.get_node("Personaje").position
