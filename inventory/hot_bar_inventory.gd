extends PanelContainer

signal hot_bar_use(index: int)

const Slot = preload("res://inventory/slot.tscn")

@onready var h_box_container = $MarginContainer/HBoxContainer

#hotkeys for the hotbar
#checks to see if the hotbar is on-screen so I can't use my hotbar if
#the inventory is open. signals 0-4 to the set_inventory_data function.
func _unhandled_key_input(event: InputEvent) -> void:
	if not visible or not event.is_pressed():
		return
	
	if range(KEY_1, KEY_6).has(event.keycode):
		hot_bar_use.emit(event.keycode - KEY_1)

#sets inventory data for the hotbar
#listens to signals and runs the populate_hot_bar function
func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_hot_bar)
	populate_hot_bar(inventory_data)
	hot_bar_use.connect(inventory_data.use_slot_data)

#populates the hotbar
#clears out the hotbar and adds the first 5 slots of the player inventory
func populate_hot_bar(inventory_data: InventoryData) -> void:
	for child in h_box_container.get_children():
		child.queue_free()
		
	for slot_data in inventory_data.slot_datas.slice(0, 5):
		var slot = Slot.instantiate()
		h_box_container.add_child(slot)
		
		if slot_data:
			slot.set_slot_data(slot_data)
