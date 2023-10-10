class_name Collectable extends Spatial


func _ready():
	var visibilityNotifie :VisibilityNotifier = VisibilityNotifier.new()
	visibilityNotifie.name = "notifie"
	add_child(visibilityNotifie)
	
	visibilityNotifie.connect("camera_exited",self,"hide")

