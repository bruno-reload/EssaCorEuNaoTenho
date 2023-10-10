class_name SpawnCoordinator extends Spatial

const line = 2
const column = 2

onready var timer = $Timer

var street_gap :float = 3.0 setget set_street_gap, get_street_gap
var level_gap :float = 5.0 setget set_level_gap, get_level_gap

var list :Array = [] setget set_list, get_list
var h_list :Array = [] setget set_h_list, get_h_list

var position :Vector3 = Vector3.ZERO
var target :Node = null

var index :int = 0

func _ready():
	for j in range(0, line * 2 + 1):
		for i in range(-column, column + 1):
			list.append(Vector3(i * street_gap , j * level_gap  + transform.origin.y, transform.origin.z))
	
	new_object()
	
	timer.wait_time = v_time(level_gap, GameParam.gravity) + h_time(GameParam.speed, street_gap)
	timer.connect("timeout", self, "new_object")

# warning-ignore:unused_argument
func set_list(var value :Array):
	pass

func get_list():
	return null
# warning-ignore:unused_argument
func set_h_list(var value :Array):
	pass

func get_h_list():
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

func random_position() -> Vector3:
	position = list[index]
	index = (index + 1) % list.size()
	return position

func step_random_position():
	position = h_list[index]

func new_object():
	randomize()
	list.shuffle()
	random_position()

static func v_time(jump_height, gravity):
	return jump_height / sqrt(2.0 * abs(GameParam.gravity) * jump_height)
	
static func h_time(speed, space):
	return space/speed
