extends Node

signal set_burst(_flg:bool)

## チャージの開始
signal start_charge()
## チャージ狩猟（バースト）
signal shot_charge()
## チャージ中の数値
signal update_chage(_value:float, _max_value:float)

## Spawnさせる
signal set_spawn(_data:Dictionary)

## プレイヤーダメージ時
signal hit_player(_hp:int, _damage:int)
## XP加算
signal add_xp(_xp:int, _next_xp:int)
## HP変化
signal change_hp(_hp:int, max_hp)

## 敵のkill
signal kill_enemy(_keyname:String)
