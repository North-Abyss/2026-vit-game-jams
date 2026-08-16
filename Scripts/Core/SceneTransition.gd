extends CanvasLayer
# Autoloaded as 'SceneTransition'

@onready var color_rect: ColorRect = $ColorRect
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Ensure the color rect doesn't block mouse clicks initially
	if color_rect:
		color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		color_rect.color.a = 0 # Fully transparent

func change_scene(target_scene: String) -> void:
	# 1. Block mouse clicks during transition
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	# 2. Fade to black
	anim_player.play("fade_to_black")
	await anim_player.animation_finished
	
	# 3. Change the scene
	get_tree().change_scene_to_file(target_scene)
	
	# 4. Fade back to normal
	anim_player.play("fade_to_normal")
	await anim_player.animation_finished
	
	# 5. Allow mouse clicks again
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
