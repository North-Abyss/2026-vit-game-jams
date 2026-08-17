extends Node
class_name BGMPlayer

@export var background_music: AudioStream

func _ready() -> void:
	if background_music and AudioManager and AudioManager.has_method("play_bgm"):
		AudioManager.play_bgm(background_music)
