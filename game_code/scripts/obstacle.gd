class_name Obstacle extends StaticBody

export(NodePath) var spawn_coordinator :NodePath
var sp_node :Node

func _ready():
	sp_node = get_node_or_null(spawn_coordinator) as SpawnCoordinator
	transform.origin = sp_node.random_position()

func _process(delta):
	transform.origin.z += delta * GameParam.speed

func extents() -> Vector3:
	return $CollisionShape.shape.extents
	

