extends KinematicBody2D

var sprites

func _ready():
	sprites = get_node("AnimatedSprite")
	sprites.play("Normal")

