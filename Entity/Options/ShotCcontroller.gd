extends Node2D

## 
@export var bullet_name:String = 'enemy_bullet'
## ショット間隔
@export var shot_timer:float = 1.0

var actor:actor_base
var timer:float = 0.0

func _ready() -> void:
	reset_timer()


func _process(_delta: float) -> void:
	timer = timer - _delta if timer > 0.0 else 0.0
	if timer <= 0.0:
		shot()
		reset_timer()

func reset_timer():
	timer = shot_timer


func shot():
	if !Game.is_active(actor.target_actor):
		return
	## ここが将来的にPOOLから取得する
	var _bullet:bullet_base = Game.poolbase.get_entity(bullet_name)
	_bullet.activate({
		'start_position': actor.global_position,
		'direction': (actor.target_actor.global_position - actor.global_position).normalized(),
	})
