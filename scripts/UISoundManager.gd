extends Node

const SFX_MOVE = preload("res://Audio/Sfx/menu_change.ogg")
const SFX_ACCEPT = preload("res://Audio/Sfx/menu_accept.ogg")
const SFX_DECLINE = preload("res://Audio/Sfx/menu_cancel.ogg")
const SFX_TEXT_POP_UP = preload("res://Audio/Sfx/text_pop_up.wav")
const SFX_INFO_CARD = preload("res://Audio/Sfx/info_card.wav")

var player_pool: Array[AudioStreamPlayer] = []
const POOL_SIZE = 4

func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	for i in range(POOL_SIZE):
		var p = AudioStreamPlayer.new()
		p.bus = "ui" 
		add_child(p)
		player_pool.append(p)

func _input(event: InputEvent) -> void:
	
	var focus_owner = get_viewport().gui_get_focus_owner() if get_viewport() else null
	
	var is_ui_active: bool = (focus_owner != null) or get_tree().paused

	if not is_ui_active:
		return
	
	if event.is_action_pressed("mover_arriba"):
		play_sfx(SFX_MOVE)
	elif event.is_action_pressed("mover_abajo"):
		play_sfx(SFX_MOVE)
	elif event.is_action_pressed("aceptar"):
		play_sfx(SFX_ACCEPT)
	elif event.is_action_pressed("cancelar"):
		play_sfx(SFX_DECLINE)

func play_sfx(stream: AudioStream) -> void:
	
	for player in player_pool:
		if not player.playing:
			player.stream = stream
			player.play()
			return
	player_pool[0].stream = stream
	player_pool[0].play()

func play_text_pop_up() -> void:
	play_sfx(SFX_TEXT_POP_UP)

func play_info_card() -> void:
	play_sfx(SFX_INFO_CARD)
