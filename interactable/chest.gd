extends StaticBody3D

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData

#signals Main to set the external inventory owner to this chest when the
#player interacts with it
func player_interact() -> void:
	toggle_inventory.emit(self)
