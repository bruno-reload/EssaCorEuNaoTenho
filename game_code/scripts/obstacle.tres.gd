class_name Obstacle extends Spatial

func _process(delta):
	transform.origin.z += delta * GameParam.speed

func extents() -> Vector3:
	return $CollisionShape.shape.extents
	

