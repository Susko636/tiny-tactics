class_name SettingsMenu
extends Control

signal back_requested
signal audio_selected
signal controls_selected

@onready var audio_button: Button = $PanelContainer/VBoxContainer/AudioContainer/HBoxContainer/AudioButton
@onready var controls_button: Button = $PanelContainer/VBoxContainer/ControlsContainer/HBoxContainer/ControlsButton
@onready var panel_container: PanelContainer = $PanelContainer
@onready var controls_card: ControlsCard = $ControlsCard
@onready var audio_card: AudioCard = $AudioCard

func _ready() -> void:
	
	audio_button.pressed.connect(_on_audio_pressed)
	controls_button.pressed.connect(_on_controls_pressed)
	
	controls_card.closed.connect(_on_controls_closed)
	audio_card.closed.connect(_on_audio_closed)

func open() -> void:
	show()
	audio_button.grab_focus()

func close() -> void:
	hide()
	back_requested.emit()

func _input(event: InputEvent) -> void:
	
	if not visible:
		return
	
	if controls_card and controls_card.visible:
		return

	if visible and (event.is_action_pressed("cancelar")):
		get_viewport().set_input_as_handled()
		close()

func _on_audio_pressed() -> void:
	
	audio_selected.emit()
	if audio_card:
		audio_card.open()

func _on_controls_pressed() -> void:
	
	controls_selected.emit()
	if controls_card:
		controls_card.open()

func _on_controls_closed() -> void:
	
	if controls_button:
		controls_button.grab_focus()

func _on_audio_closed() -> void:
	
	if audio_button:
		audio_button.grab_focus()
