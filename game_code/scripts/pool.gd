extends Node

var position :int = 0
var lists :Dictionary
var inside :Dictionary 


func add(key :String, value):
	inside[key].append(true)
	lists[key].append(value)

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

func new_list(key :String):
	inside = {key:[]}
	lists = {key:[]}

