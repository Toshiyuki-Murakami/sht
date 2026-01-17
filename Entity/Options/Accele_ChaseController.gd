extends chase_controller
class_name accele_chase_controller

## 最大加速までの時間
@export var accele_time:float = 1.0
## 
@export var wait_time:float = 0.5
## wait中のスピード
@export var wait_speed:float = 100.0

var accele_timer:float = 0.0
var rate:float = 0.0
var onetime:bool = false

func _process(_delta: float) -> void:
	super(_delta)
	accele_timer += _delta
	rate = accele_timer / accele_time if accele_timer < accele_time else 1.0
	

	
func _on_change_activate(_data:Dictionary):
	super(_data)

func _on_change_deactivate():
	super()
	accele_timer = 0.0
	rate = 0.0
	onetime = false


func check_target():
	## 一度ターゲットしている場合は再ターゲットしない
	if onetime:
		return false
	## waitタイム中はホーミングしない
	if accele_timer < wait_time:
		actor.velocity = actor.direction.normalized() * wait_speed
		return false
	return super()

func homing(_delta:float):
	if !super(_delta):
		onetime = true
	## 加速スピードをコントロール
	actor.velocity = actor.velocity.normalized() * actor.speed * rate
