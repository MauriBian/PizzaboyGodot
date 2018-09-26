extends Node2D

var timer
var label

func _ready():
	label = get_node("CanvasLayer/Label")
	timer = Timer.new()
	timer.wait_time = 4
	timer.connect("timeout",self,"comenzar")
	add_child(timer)
	timer.start()
	get_tree().paused = true
	
func _process(delta):
	label.text = String(int((timer.time_left)))
func comenzar():
	get_tree().paused = false
	self.queue_free()
