extends Node


var Resources:Dictionary = {
	## Enemy
	'enemy_triangle01': preload("res://Entity/EnemyTriangle01.tscn").instantiate(),
	'enemy_square128': preload("res://Entity/EnemySquare128.tscn").instantiate(),
	'enemy_circle01': preload("res://Entity/EnemyCircle01.tscn").instantiate(),
	'enemy_cross': preload("res://Entity/EnemyCross.tscn").instantiate(),
	
	## bullet
	'main_bullet': preload("res://Entity/bullet/MainBullrt.tscn").instantiate(),
	'enemy_bullet': preload("res://Entity/bullet/EnemyBullrt.tscn").instantiate(),
	'enemy_bullet02': preload("res://Entity/bullet/EnemyBullrt02.tscn").instantiate(),
	
	## effect
	'effect_playerdeath': preload("res://Entity/Effect/Effect_PlayerDeath.tscn").instantiate(),
	'effect_death': preload("res://Entity/Effect/EffectDeath.tscn").instantiate(),
	'effect_collision': preload("res://Entity/Effect/EffectCollision.tscn").instantiate(),
	'effect_circle': preload("res://Entity/Effect/Effect_Circle.tscn").instantiate(),
	'effect_bullethit': preload("res://Entity/Effect/Effect_BulletHit.tscn").instantiate(),
	
	## etc
	'exp_ball': preload("res://Entity/etc/EXP_Ball.tscn").instantiate(),
}

func get_duplicate(_name:String):
	if Resources.has(_name):
		return Resources[_name].duplicate()
	return null
