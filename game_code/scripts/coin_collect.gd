extends "res://scripts/collectable.gd"
const key :String = "coins"

var feedback :bool = false

##############################################################
##################### system code ############################
##############################################################

func  _ready():
	connect("body_entered", self , "_on_body_entered")

func _process(delta):
	moviment_state(delta)

func _on_body_entered(body :Node):
	if body.name == "Player":
		collected_state(body)

##############################################################
######################### overload ###########################
##############################################################

func hide(camera = null):
	Pool.take_it(key, self)
	initial_state()
	.hide()

func show():
	$coin.show()
	$shine.show()
	.show()
	
##############################################################
################### function state ###########################
##############################################################

func initial_state():
	$particle.hide()
	transform.origin = Vector3.ZERO
	feedback = false

func moviment_state(delta):
	if not feedback:
		transform.origin.z += delta * GameParam.speed

func collected_state(node :Node):
	feedback = true
	global_transform.origin.z = node.global_transform.origin.z
	$coin.hide()
	$shine.hide()
	$particle.show()
	$particle.restart()
	$sound.play()
	
	yield(get_tree().create_timer($particle.lifetime),"timeout")
	
	hide()
