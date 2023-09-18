extends Control

export(float) var delay :float = 3.0

onready var progress_bar :ProgressBar = $VBoxContainer/LoadBarSpace/ProgressBar

var loader :ResourceInteractiveLoader 
var status_complete :bool = false
var time :float = 0.0

func _ready():
	on_disable()
	MobileAds.config.banner.position = false
	MobileAds.config.banner.show_instantly = false

func on_disable():
	set_process(false)
	time = delay
	MobileAds.hide_banner()
	progress_bar.value = 0
	status_complete = false
	hide()

func on_enable(target :String):
	show()
	set_process(true)
	if MobileAds.get_is_banner_loaded():
		MobileAds.show_banner()
	loader = ResourceLoader.load_interactive(target)

func _process(delta):
	var err = loader.poll()
	if err == ERR_FILE_EOF: 
		var resource :Resource = loader.get_resource()
		progress_bar.value = progress_bar.max_value
	elif err == OK:
		var progress = float(loader.get_stage()) / loader.get_stage_count()
		progress_bar.value = progress
	if time < 0 and progress_bar.value >= progress_bar.max_value:
		on_disable()
		ControlScenes.switch_scene_to(loader.get_resource())
	if MobileAds.get_is_banner_loaded():
		time -= delta
