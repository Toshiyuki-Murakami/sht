extends Node2D
class_name enemy_controller

var start_position:Vector2
var end_position:Vector2
var direction:Vector2

var actor:enemy_base
## 目標ターゲット
var target_actor:actor_base


func _ready() -> void:
	pass


func _on_change_state(_state:actor_base.STATE):
	pass


func init_entity():
	actor.change_state.connect(_on_change_state)
	#spawn()


func spawn():
	var pos:Array = Game.get_spawn_positions()
	start_position = pos[0]
	end_position = pos[1]
	direction = Vector2(pos[1] - pos[0]).normalized()
	print_debug('[spawn]', start_position, end_position, direction)

	actor.global_position = start_position
	
	actor.velocity = direction * actor.speed
	## stateをspawnでcreateに変更
	actor.state = actor_base.STATE.CREATE
