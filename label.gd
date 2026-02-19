extends Label

var speed = 200

func _process(delta):
	position.x += speed * delta
	
	if position.x > 800:
		position.x = 0
