class_name AudioCard
extends Control

signal closed

@onready var music_slider: HSlider = $CenterContainer/NinePatchRect/MarginContainer/VBoxContainer/MusicContainer/MusicSlider
@onready var sfx_slider: HSlider = $CenterContainer/NinePatchRect/MarginContainer/VBoxContainer/SFXContainer/SFXSlider
@onready var master_slider: HSlider = $CenterContainer/NinePatchRect/MarginContainer/VBoxContainer/MasterContainer/MasterSlider

var master_bus_idx: int
var music_bus_idx: int
var sfx_bus_idx: int

func _ready() -> void:
	
	hide()
	master_bus_idx = AudioServer.get_bus_index("Master")
	music_bus_idx = AudioServer.get_bus_index("music")
	sfx_bus_idx = AudioServer.get_bus_index("sfx")

	_sync_sliders_with_server()

	master_slider.value_changed.connect(_on_master_changed)
	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)

func open() -> void:
	
	show()
	_sync_sliders_with_server()
	_grab_initial_focus.call_deferred()

func _grab_initial_focus() -> void:
	if master_slider:
		master_slider.grab_focus()

func close() -> void:
	hide()
	closed.emit()

func _sync_sliders_with_server() -> void:
	
	if master_bus_idx != -1:
		master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_idx))
	if music_bus_idx != -1:
		music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_idx))
	if sfx_bus_idx != -1:
		sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_idx))

func _input(event: InputEvent) -> void:
	
	if not visible:
		return

	if event.is_action_pressed("cancelar"):
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
		close()

func _set_volume(bus_idx: int, linear_val: float) -> void:
	
	if bus_idx == -1:
		return
	if linear_val <= 0.02:
		AudioServer.set_bus_mute(bus_idx, true)
	else:
		AudioServer.set_bus_mute(bus_idx, false)
		AudioServer.set_bus_volume_db(bus_idx, linear_to_db(linear_val))

func _on_master_changed(val: float) -> void:
	_set_volume(master_bus_idx, val)

func _on_music_changed(val: float) -> void:
	_set_volume(music_bus_idx, val)

func _on_sfx_changed(val: float) -> void:
	_set_volume(sfx_bus_idx, val)
