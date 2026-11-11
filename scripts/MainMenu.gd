class_name MainMenu
extends Control

@export_file("*.tscn") var gameplay_scene_path: String = "res://scenes/main.tscn"

@onready var menu: Menu = $Menu

func _ready() -> void:
	
	get_tree().paused = false
	Engine.time_scale = 1.0

	menu.show()
	menu.play_selected.connect(_on_play_pressed)
	menu.grab_initial_focus()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(gameplay_scene_path)
