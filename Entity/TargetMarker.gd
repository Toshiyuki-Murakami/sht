extends actor_base
class_name target_marker

func _ready() -> void:
	state = STATE.MOVE


func _process(_delta: float) -> void:
	move()


func move():
	global_position = get_global_mouse_position()
