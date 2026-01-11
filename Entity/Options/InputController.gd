extends trigger_base
class_name Input_Controller

## 上キー割り当て
@export var keymap_up:String = 'game_up'
## 下キー割り当て
@export var keymap_down:String = 'game_down'
## 左キー割り当て
@export var keymap_left:String = 'game_left'
## 右キー割り当て
@export var keymap_right:String = 'game_right'

@export var mouse_action_name:String = 'game_move'
## 発射ボタン
@export var fire_button:String = 'game_fire'


var velocity:Vector2 = Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	input_process(_delta)


func input_process(_delta:float):
	## 発射ボタン判定
	fire_trigger = Input.is_action_pressed(fire_button)
	
	if Input.is_action_just_pressed('game_shield'):
		just_change_trigger.emit(trigger_base.TRIGGER_TYPES.SHIELD, true)
	if Input.is_action_just_released('game_shield'):
		just_change_trigger.emit(trigger_base.TRIGGER_TYPES.SHIELD, false)
	if Input.is_action_just_pressed('game_chage'):
		Signals.set_burst.emit(true)
	if Input.is_action_just_released('game_chage'):
		Signals.set_burst.emit(false)	
	
	# 移動量取得
	velocity = Input.get_vector(keymap_left, keymap_right, keymap_up, keymap_down)
	# マウス
	if Input.is_action_pressed(mouse_action_name):
		velocity = get_global_mouse_position() - global_position

	actor.velocity = velocity.normalized() * actor.speed
