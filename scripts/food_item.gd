class_name FoodItem extends RigidBody3D

@onready var splatter : Decal = $FoodSplatter
@onready var splat_sprite : Sprite3D = $FoodSplatterSprite
@onready var splat_sound : AudioStreamPlayer3D = $"../SplatSound"

var food_meshes : Array[MeshInstance3D]
var compat_mode : bool

func _ready() -> void:
	compat_mode = ProjectSettings.get_setting("rendering/renderer/rendering_method") == "gl_compatibility"
	var children = get_children()
	for child in children:
		if child is MeshInstance3D:
			food_meshes.push_back(child)

func get_meshes() -> Array[MeshInstance3D]:
	return food_meshes

func _on_body_entered(body: Node) -> void:
	if not body: body = get_tree().root
	elif body.is_in_group("Food Safe"): return
	elif body is Customer: body.splat()
	splat_sound.play()
	if compat_mode:
		splat_sprite.reparent(body)
		splat_sprite.show()
	else:
		splatter.reparent(body)
		splatter.show()
	
	queue_free()
