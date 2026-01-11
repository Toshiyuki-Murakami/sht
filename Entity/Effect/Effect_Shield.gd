extends Sprite2D
class_name effect_shield

var tween:Tween

## Animation用パラメータ
var radius:float = 0.4:
	set(_value):
		radius = _value
		material.set_shader_parameter("ring_radius", radius)

var opacity:float = 1.0:
	set(_value):
		opacity = _value
		material.set_shader_parameter("opacity", opacity)

var thickness:float = 0.25:
	set(_value):
		thickness = _value
		material.set_shader_parameter("thickness_scale", thickness)	

func _ready():
	var _meterial:Material = material.duplicate(true)
	material = _meterial
	visible = false

func activate():
	visible = true
	radius = 0.25
	thickness = 0.25
	opacity = 1.0

func deactivate():
	visible = false

func hit():
	visible = true
	radius = 0.25
	opacity = 1.0
	tween = create_tween()
	tween.tween_property(self, "radius", 0.45, 0.3)
	tween.parallel().tween_property(self, "opacity", 0.0, 0.3)
	#tween.tween_property(self, "radius", 0.3, 0.3)
	tween.play()
	await tween.finished
	visible = false
