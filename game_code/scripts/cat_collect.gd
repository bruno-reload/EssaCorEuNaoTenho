extends "res://scripts/collectable.gd"

onready var meshInstance = $MeshInstance
export(Resource) var cat

func _ready():
	meshInstance.mesh = cat.body
	meshInstance.mesh.material = cat.material
	meshInstance.mesh.material.albedo_texture = cat.animal
	connect("body_entered", self, "collected")


func _process(delta):
	transform = transform.translated(Vector3.BACK * GameParam.speed * delta )

func collected(node :Node):
	if node is KinematicBody and node.name == "Player":
		$MeshInstance.hide()
