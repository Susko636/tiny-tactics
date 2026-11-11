class_name Menu
extends Control

signal play_selected

@onready var panel_container: Control = $PanelContainer
@onready var background: NinePatchRect = $Background
@onready var settings_menu: SettingsMenu = $SettingsMenu

@onready var play_button: Button = $PanelContainer/VBoxContainer/PlayContainer/HBoxContainer/PlayButton
@onready var settings_button: Button = $PanelContainer/VBoxContainer/SettingsContainer/HBoxContainer/SettingsButton

func _ready() -> void:
	
	panel_container.show()
	background.show()
	settings_menu.hide()

	play_button.pressed.connect(_on_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)

	settings_menu.back_requested.connect(_on_settings_back)

func grab_initial_focus() -> void:
	if play_button:
		play_button.grab_focus()

func _input(event: InputEvent) -> void:
	
	if not settings_menu or not settings_menu.visible:
		return

	if event.is_action_pressed("cancelar"):
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
		_on_settings_back()

func _on_play_pressed() -> void:
	play_selected.emit()

func _on_settings_pressed() -> void:
	
	panel_container.hide()
	background.hide()
	settings_menu.open()

	_focus_settings_button.call_deferred()

func _focus_settings_button() -> void:
	
	if settings_menu and settings_menu.audio_button:
		settings_menu.audio_button.grab_focus()

func _on_settings_back() -> void:
	
	settings_menu.hide()
	panel_container.show()
	background.show()

	_focus_menu_button.call_deferred()

func _focus_menu_button() -> void:
	if settings_button:
		settings_button.grab_focus()
