class_name Arrow
extends Area2D

@export var speed: float = 420.0
@export var arc_height: float = 36.0

var start_pos: Vector2
var target_pos: Vector2
var travel_time: float = 0.4
var elapsed_time: float = 0.0

func setup(origin: Vector2, destination: Vector2) -> void:
	top_level = true
	z_index = 20 # Asegura que se dibuje por encima del TileMap y las unidades
	
	global_position = origin
	start_pos = origin
	target_pos = destination
	
	var total_distance: float = start_pos.distance_to(target_pos)
	travel_time = maxf(0.1, total_distance / speed)

func _physics_process(delta: float) -> void:
	elapsed_time += delta
	var t: float = clampf(elapsed_time / travel_time, 0.0, 1.0)
	
	# Interpolación lineal en el plano (funciona en horizontal, vertical y diagonal)
	var current_base: Vector2 = start_pos.lerp(target_pos, t)
	
	# Elevación parabólica en el eje Y visual
	var height_offset: float = -4.0 * arc_height * t * (1.0 - t)
	var next_pos: Vector2 = Vector2(current_base.x, current_base.y + height_offset)
	
	# Rotar la flecha en la dirección exacta en la que se mueve
	var move_vector: Vector2 = next_pos - global_position
	if move_vector.length_squared() > 0.001:
		rotation = move_vector.angle()
		
	global_position = next_pos
	
	if t >= 1.0:
		queue_free()
