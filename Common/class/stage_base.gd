extends Node2D
class_name stage_base

var init_entity:String = 'init_stage'

func _ready() -> void:
	_set_base_recursively(self)


## Treeのstageを全てにセット
func _set_base_recursively(node: Node, _keyword:String = 'stage'):
	# base変数を持っていたらセット
	if _keyword in node:
		node.set(_keyword, self)
		if node.has_method(init_entity):
			node.init_entity()

	# 子ノードにも再帰的に適用
	for child in node.get_children():
		_set_base_recursively(child, _keyword)
