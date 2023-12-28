extends Resource
class_name Attribute

@export var attribute_modifier: float = 1.00
@export_range(1, 99) var attribute_value: int = 1
var attribute_total: float = attribute_value * attribute_modifier
