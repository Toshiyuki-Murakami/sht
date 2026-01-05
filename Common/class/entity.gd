extends Node2D
class_name entity_base

## 共通親変数名
@export var base_name:String = 'actor'
## 親変数設定時の関数名
@export var init_entity:String = 'init_entity'

var active:bool = false
## pool処理用設定
var poolbase:pool_base
var poolkey:String = ''

var process_functions:Array = []

var start_position:Vector2 = Vector2(100, 100)
var end_position:Vector2
var direction:Vector2 = Vector2(1, 1).normalized()

## 移動量
var velocity:Vector2

func _ready() -> void:
	_set_base_recursively(self, base_name)

## Poolからアクティベートするための関数
func activate(_data:Dictionary = {}):
	active = true
	visible = true
	## dataの設定
	if _data.has('start_position'):
		start_position = _data.start_position
		global_position = _data.start_position
	if _data.has('end_position'):
		end_position = _data.end_position
	if _data.has('direction'):
		direction = _data.direction
	if _data.has('modulate'):
		modulate = _data.modulate


	set_process(true)
	set_physics_process(true)
	## poolから外す
	if poolbase:
		poolbase.out_pool(self)

## Poolへ戻す関数
func deactivate():
	active = false
	visible = false
	set_process(false)
	set_physics_process(false)
	## poolに入れる
	if poolbase:
		poolbase.in_pool(self)


## Treeのactorを全てにセット
func _set_base_recursively(node: Node, _keyword:String = 'actor'):
	# base変数を持っていたらセット
	if _keyword in node:
		node.set(_keyword, self)
		if node.has_method(init_entity):
			node.init_entity()

	# 子ノードにも再帰的に適用
	for child in node.get_children():
		_set_base_recursively(child, _keyword)
