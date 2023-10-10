extends Camera

var t = 0.0

func _ready():
	print(get_world())

func _process(delta):
	t += delta
	
	t = clamp(t, 0, 1)
	
	var fov
	
