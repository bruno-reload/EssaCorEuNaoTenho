class_name SpawnAnimals extends Node

export(NodePath) var spawnCoordinate
export(PackedScene) var animals

func _ready():
	spawnCoordinate = get_node_or_null(spawnCoordinate)
	

func _on_timeout():
	var animal_node = animals.instance()
	animal_node.transform.origin = (spawnCoordinate as SpawnCoordinator).random_position() 
	add_child(animal_node)
