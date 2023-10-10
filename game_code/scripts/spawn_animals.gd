class_name SpawnAnimals extends Node

export(NodePath) var spawn_coordinate
export(PackedScene) var animals

func _ready():
	spawn_coordinate = get_node_or_null(spawn_coordinate)
	

func _on_timeout():
	var animal_node = animals.instance()
	animal_node.transform.origin = (spawn_coordinate as SpawnCoordinator).random_position() 
	add_child(animal_node)
