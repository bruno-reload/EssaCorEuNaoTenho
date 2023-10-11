class_name Collectable extends Spatial


func _ready():
	var visibilityNotifie :VisibilityNotifier = VisibilityNotifier.new()
	visibilityNotifie.name = "notifie"
	add_child(visibilityNotifie)
	
	assert(not visibilityNotifie.connect("camera_exited",self,"hide"),"não foi possivel se conectar")

