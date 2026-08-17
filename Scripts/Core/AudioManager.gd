extends Node
# Autoload this script as 'AudioManager'

var bgm_player: AudioStreamPlayer
var alarm_player: AudioStreamPlayer
var attack_player: AudioStreamPlayer

func _ready() -> void:
	# Background Music
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	bgm_player.volume_db = -10.0
	
	# Wave Alarm
	alarm_player = AudioStreamPlayer.new()
	add_child(alarm_player)
	
	# Attack Sounds
	attack_player = AudioStreamPlayer.new()
	add_child(attack_player)

# --- Functions for other scripts to call ---

func play_bgm(stream: AudioStream) -> void:
	if stream:
		bgm_player.stream = stream
		bgm_player.play()

func play_alarm(stream: AudioStream = null) -> void:
	if stream: alarm_player.stream = stream
	if alarm_player.stream:
		alarm_player.play()

func play_attack(stream: AudioStream = null) -> void:
	if stream: attack_player.stream = stream
	if attack_player.stream:
		attack_player.play()
