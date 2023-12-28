extends Resource
class_name ItemData

@export var name: String = ""
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var consumable: bool = false
@export var equipment: bool = false
@export var healing: bool = false
@export var heal_value: int = 0
@export var texture: AtlasTexture

func use(target) -> void:
	if healing and heal_value != 0:
		target.heal(heal_value)
