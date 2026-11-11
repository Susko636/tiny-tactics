class_name PauseMenu
extends Control

signal resumed
signal restart_requested
signal main_menu_requested

@onready var main_panel: Control = $PanelContainer
@onready var settings_menu: SettingsMenu = $SettingsMenu
@onready var background: NinePatchRect = $Background
@onready var label: Label = $Label

@onready var resume_button: Button = $PanelContainer/VBoxContainer/ResumeContainer/HBoxContainer/ResumeButton
@onready var restart_button: Button = $PanelContainer/VBoxContainer/RestartContainer/HBoxContainer/RestartButton
@onready var settings_button: Button = $PanelContainer/VBoxContainer/SettingsContainer/HBoxContainer/SettingsButton
@onready var quit_button: Button = $PanelContainer/VBoxContainer/QuitContainer/HBoxContainer/QuitButton

func _ready() -> void:
	
	hide()
	settings_menu.hide()

	resume_button.pressed.connect(_on_resume_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	settings_menu.back_requested.connect(_on_settings_back)

func _unhandled_input(event: InputEvent) -> void:

	if settings_menu.visible:
		return

	if event.is_action_pressed("pausa"):
		get_viewport().set_input_as_handled()
		if visible:
			close_pause()
		else:
			open_pause()

func open_pause() -> void:
	
	show()
	main_panel.show()
	settings_menu.hide()
	get_tree().paused = true
	resume_button.grab_focus()

func close_pause() -> void:
	
	hide()
	settings_menu.hide()
	get_tree().paused = false
	resumed.emit()

func _on_resume_pressed() -> void:
	close_pause()

func _on_restart_pressed() -> void:
	
	get_tree().paused = false
	hide()
	restart_requested.emit()

func _on_settings_pressed() -> void:
	
	background.hide()
	main_panel.hide()
	label.hide()
	settings_menu.open()

func _on_settings_back() -> void:
	
	background.show()
	main_panel.show()
	label.show()
	settings_button.grab_focus()

func _on_quit_pressed() -> void:
	
	get_tree().paused = false
	hide()
	main_menu_requested.emit()
