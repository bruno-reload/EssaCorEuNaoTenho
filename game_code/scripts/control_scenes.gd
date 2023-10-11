extends Node

export(float) var time = 3

var loadScreen  :Node

func _ready():
	assert(not MobileAds.connect("initialization_complete", self, "_on_MobileAds_initialization_complete"), "não foi possivel se conectar")
	
	loadScreen = load(ProjectSettings.get_setting("ControlScenes/loadScreem")).instance()
	add_child(loadScreen)


func _on_MobileAds_initialization_complete(status : int, adapter_name : String) -> void:
	if status == MobileAds.AdMobSettings.INITIALIZATION_STATUS.READY:
		MobileAds.load_banner()
		MobileAds.load_interstitial()
		MobileAds.load_rewarded()
		MobileAds.load_rewarded_interstitial()


func change_to(target :String):
	loadScreen.on_enable(target);

func switch_scene_to(resource :Resource):
	get_tree().root.add_child(resource.instance())

func clean(node :Node):
	var root = node.get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count() -1)
	current_scene.queue_free()

func switch_error_scene():
	pass
