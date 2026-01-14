extends chase_controller
class_name shotstop_chase_controller

## 1周の時間
@export var loop_time:float = 4.0
## 半径
@export var radius:float = 400.0


var loop_timer:float = 0.0
var move_angle:float = 0.0

func _process(_delta: float) -> void:
	super(_delta)
	loop_timer += _delta
	loop_timer = loop_timer - loop_time if loop_timer > loop_time else loop_timer
	move_angle = deg_to_rad(360.0 * loop_timer / loop_time)

func face():
	if actor.hold == true:
		return
	if to_face:
		if actor.target_actor:
			var _angle:float = (actor.target_actor.global_position - actor.global_position).angle()
			actor.rotation = _angle
		else:
			super()

func homing(_delta:float):
	if actor.hold == true:
		return
	super(_delta)

func get_target_position():
	var _pos:Vector2 = Vector2(radius, 0).rotated(move_angle)
	return actor.target_actor.global_position + _pos
