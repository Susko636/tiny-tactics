class_name UnitStateAttack
extends UnitState

@export var arrow_scene: PackedScene = preload("res://scenes/world/units/allys/arrow.tscn")
@export var launch_frame: int = 5 
var arrow_fired: bool = false

func enter() -> void:
	
	arrow_fired = false
	
	if unit.sprite and unit.sprite.sprite_frames and unit.sprite.sprite_frames.has_animation("attack"):
		if not unit.sprite.frame_changed.is_connected(_on_frame_changed):
			unit.sprite.frame_changed.connect(_on_frame_changed)
			
		unit.sprite.play("attack")
		
func exit() -> void:
	
	if unit.sprite and unit.sprite.frame_changed.is_connected(_on_frame_changed):
		unit.sprite.frame_changed.disconnect(_on_frame_changed)

func _on_frame_changed() -> void:
	
	if unit.sprite.animation == "attack" and unit.sprite.frame == launch_frame and not arrow_fired:
		if arrow_scene and unit.max_range > 1 and not unit.is_healer:
			_shoot_arrow()

func _shoot_arrow() -> void:
	
	arrow_fired = true
	
	var arrow = arrow_scene.instantiate() as Arrow
	unit.add_child(arrow)
	
	var facing: float = -1.0 if (unit.sprite and unit.sprite.flip_h) else 1.0
	var spawn_pos: Vector2 = unit.global_position + Vector2(16.0 * facing, -8.0)
	
	var target_pos: Vector2 = unit.last_target_world_pos
	if target_pos == Vector2.ZERO:
		target_pos = unit.global_position + Vector2(64.0 * 3.0 * facing, 0.0)
		
	arrow.setup(spawn_pos, target_pos)
