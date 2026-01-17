extends bullet_base

@export var effect_name:String = 'effect_trail'

func activate(_data:Dictionary = {}):
	super(_data)



	var _bullet:entity_base = Game.poolbase.get_entity(effect_name)
	if _bullet:
		_bullet.activate({
			'start_position': Vector2(0, 0),
			'owner_actor': self,
			'modulate': image_base.image_base.modulate,
		})
