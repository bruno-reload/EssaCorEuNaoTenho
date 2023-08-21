class_name SpawnCoordinator extends Spatial

const line = 2
const column = 3

export(float) var street_gap :float = 3.0 setget set_street_gap, get_street_gap
export(float) var level_gap :float = 5.0 setget set_level_gap, get_level_gap

export(NodePath) var center :NodePath
var target :Node = null
var position :Vector3 = Vector3.ZERO
var list_x :Array = [] setget set_list_x, get_list_x
var list_y :Array = [] setget set_list_y, get_list_y

var index :int = 0

func _ready():
	for i in range(-column, column + 1):
		list_x.append(i)
	for i in range(-line, line + 1):
		list_y.append(i)
	randomize()
	list_x.shuffle()
	list_y.shuffle()
		
	target = get_node_or_null(center)

# warning-ignore:unused_argument
func set_list_x(var value :Array):
	pass

func get_list_x():
	return null

# warning-ignore:unused_argument
func set_list_y(var value :Array):
	pass

func get_list_y():
	return null

# warning-ignore:unused_argument
func set_street_gap(var value :float):
	pass

func get_street_gap() -> float:
	return street_gap

func get_level_gap() -> float:
	return level_gap

# warning-ignore:unused_argument
func set_level_gap(var value :float):
	pass

func arbitrary_number():
	position = Vector3(list_x[index], list_y[index], 0)
	if line <= column:
		index = (index + 1) % (line * 2 + 1)
	else:
		index = (index + 1) % (column * 2 + 1)
	
	return Vector3(list_x[index], list_y[index], 0)



