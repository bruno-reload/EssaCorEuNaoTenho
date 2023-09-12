class_name Obstacle extends StaticBody

export(NodePath) var sp :NodePath
var sp_node :Node

func _ready():
	sp_node = get_node_or_null(sp) as SpawnCoordinator
	transform.origin = sp_node.random_position()

func _process(delta):
	transform.origin.z += delta * GameParam.speed

func extents() -> Vector3:
	return $CollisionShape.shape.extents
	

