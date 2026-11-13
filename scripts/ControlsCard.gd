class_name ControlsCard
extends Control

signal closed

func _ready() -> void:
	
	hide()

func open() -> void:
	
	show()

func close() -> void:
	hide()
	closed.emit()

func _input(event: InputEvent) -> void:
	
	if not visible:
		return

	if event.is_action_pressed("cancelar"):
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
		close()
