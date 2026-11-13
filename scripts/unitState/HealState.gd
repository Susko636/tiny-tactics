class_name UnitStateHeal
extends UnitState

func enter() -> void:
	
	if unit.heal_effect_sprite and unit.heal_effect_sprite.sprite_frames:
		unit.heal_effect_sprite.show()
		unit.heal_effect_sprite.frame = 0
		unit.heal_effect_sprite.play("heal")

func exit() -> void:
	if unit.heal_effect_sprite:
		unit.heal_effect_sprite.hide()
