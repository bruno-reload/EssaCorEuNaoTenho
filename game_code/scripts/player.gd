class_name Player extends KinematicBody

export(float) var dragging_magnitude: float = 10.0


export(float) var speed :float = 20
export(float) var street :int = 0
export(NodePath) var sp :NodePath

var velocity :Vector3 = Vector3.ZERO
var pressed = false
var dir :int = 0
var h_moviment :bool = false
var v_count :int = 0
var h_count :int = 0
var floor_entere :bool = false
var jump_height :float = 0.0
var sp_node :SpawnCoordinator

func _ready():
	sp_node = get_node_or_null(sp)
	jump_height = sp_node.level_gap

func _unhandled_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		pressed = true

	if event is InputEventScreenDrag:
		if event.relative.length() > dragging_magnitude and pressed:
			handle_drag(event)

func handle_drag(event: InputEventScreenDrag):
	var teta = rad2deg(event.relative.angle_to(Vector2.UP))

	if teta > 45 and teta < 135:
		move_left()
	elif teta < -45 and teta > -135:
		move_right()
	elif teta < 45 and teta > -45:
		jump()
	else:
		slide()  # Para o slide

	pressed = false

func _physics_process(var delta :float):
	if not h_moviment:
		velocity = move_and_slide(velocity, Vector3.UP)
		velocity.y += delta * GameParam.gravity
	if is_on_floor():
		v_count = 0
		h_count = 0
		velocity.y = 0.0

func _process(delta):
	horizontal_moviment(delta)

func jump():
	if v_count <  sp_node.line * 2 :
		v_count = int(clamp(v_count + 1, 0, sp_node.line * 2 + 1))
		velocity.y = sqrt(2.0 * abs(GameParam.gravity) * jump_height)

func horizontal_moviment(var delta :float) -> void:
	h_moviment = false
	var m_collide :KinematicCollision = null
	if h_count < sp_node.column * 2 + 1 :
		if transform.origin.x * dir < street * sp_node.street_gap * dir:
			h_moviment = true
			m_collide = move_and_collide(dir * speed * delta * Vector3.RIGHT)
			if m_collide != null and m_collide.collider is Obstacle:
	#			m_collide.collider is Obstacle nesse ponto o obstaculo vai dar um feedback de colisão
				dir = -dir
				street = int(clamp(street + dir, -sp_node.column ,sp_node.column * 2 + 1 ))
				m_collide = move_and_collide(dir * speed * delta * Vector3.RIGHT)
		else:
			dir = 0
			velocity.x = 0
			transform.origin.x = street * sp_node.street_gap

func move_left():
	dir = -1 
	street = int(clamp(street - 1, -sp_node.line  ,sp_node.line ))
	h_count = int(clamp(h_count +  1, 0, sp_node.column * 2 + 1))

func move_right():
	dir = 1
	street = int(clamp(street + 1, -sp_node.line  ,sp_node.line ))
	h_count = int(clamp(h_count +  1, 0, sp_node.column * 2 + 1))

func slide():
	pass



