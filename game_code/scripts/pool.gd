extends Node

var position :int = 0
var lists :Dictionary
var inside :Dictionary 
var buffer :Dictionary


func add(key :String, value):
	inside[key].append(true)
	lists[key].append(value)

func create_population(valeu :int, key :String, target :PackedScene):
	var node = target.instance()
	assert(not buffer.has(key), "já exite um grupo de itens com esse nome, modifique o nome para algo diferente.")
	
	create_buffer(key, node)
	for i in range(0, valeu):
		var e = buffer[key].duplicate()
		e.name = key + str(i)
		add(key, e)

func objetct_factory(key :String):
	var e = buffer[key].duplicate()
	e.name = key + str(lists[key].size())
	add(key, e)
	return release(key)

func remove(key :String, value):
	if lists[key].has(value):
		lists[key].remove(value)

func take_it(key, target):
	var index :int = lists[key].find(target)
	inside[key][index] = true

func release(key):
	var index :int = -1
	if inside[key].has(true):
		index = inside[key].find(true)
		if index < 0:
			return null
		inside[key][index] = false
	else:
		return null
	return lists[key][index]

func create_buffer(key :String, target :Node):
	inside = {key:[]}
	lists = {key:[]}

	buffer = {key: target}

