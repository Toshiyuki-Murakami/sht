extends actor_controller_base
class_name chase_controller

## ターゲット認識させる距離
@export var target_in_radius:float = 400.0
## 視野角
@export var fov:float = 180.0
## ターゲットするグループ名
@export var target_group:String = Global.PLAYER_GROUP
## ターンスピード
@export var turn_speed:float = 5.0
## 進行方向に自動的に回転させる
@export var to_face:bool = false

var is_chase:bool = false

func _process(_delta: float) -> void:
	if check_target():
		homing(_delta)
	face()

func _on_change_state(_state:actor_base.STATE):
	if _state == actor_base.STATE.MOVE:
		set_process(true)
	else:
		set_process(false)

func _on_change_deactivate():
	super()
	is_chase = false
	actor.target_actor = null
	actor.velocity = Vector2.ZERO

func init_entity():
	super()
	actor.change_state.connect(_on_change_state)
	## 初期化
	is_chase = false
	actor.target_actor = null

func face():
	if to_face:
		var _angle:float = actor.velocity.angle()
		actor.rotation = _angle

func check_target():
	## 既に追跡モードなら処理しない
	if is_chase:
		return true
	## 対象グループ取得
	var nodes_in_group = get_tree().get_nodes_in_group(target_group)
	var min_dist:float = 9999.9
	var min_node:actor_base = null
	for _node in nodes_in_group:
		var _dist:float = actor.global_position.distance_to(_node.global_position)
		var _angle:float = (_node.global_position - actor.global_position).angle()
		if _dist <= target_in_radius:
			## 扇判定
			if is_in_fov(actor.global_position, actor.rotation, _node.global_position, deg_to_rad(fov)):
				if min_dist > _dist:
					min_dist = _dist
					min_node = _node
	
	if min_node:
		is_chase = true
		actor.target_actor = min_node
		actor.change_trigger.emit(trigger_base.TRIGGER_TYPES.FIRE, true)
		return true
	
	return false


func homing(_delta:float):
	if !Game.is_active(actor.target_actor):
		is_chase = false
		return false
	var to_target:Vector2 = (actor.target_actor.global_position - actor.global_position).normalized()
	var current_direction = Vector2.RIGHT.rotated(actor.velocity.angle())	

	var new_direction:Vector2 = current_direction.lerp(to_target, turn_speed * _delta).normalized()
	actor.velocity = new_direction * actor.speed	
	
	return true
	
func is_in_fov(origin: Vector2, forward_angle: float, target: Vector2, _fov: float) -> bool:
	var dir := (target - origin).normalized()
	var angle := dir.angle()
	return abs(wrapf(angle - forward_angle, -PI, PI)) <= _fov * 0.5
