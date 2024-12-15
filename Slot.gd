extends Panel

@onready var item_visual : Sprite2D = $Sprite2D
<<<<<<< Updated upstream
=======
var player : Node
var inventory_Base_node : Node
func initialize(player_ref: Node, inventory_ref : Node):
	player = player_ref
	inventory_Base_node = inventory_ref
>>>>>>> Stashed changes
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Slot_update(item:InvItem):
	if item:
		item_visual.texture = item.Item_Texture
		if item.Item_quantity > 1:
			$Label.visible = true
			$Label.text = str(item.Item_quantity)
		else:
			$Label.visible = false
	else:
		pass
<<<<<<< Updated upstream

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
=======
		
func _on_gui_input(event: InputEvent) -> void:
	##if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
	if Input.is_action_just_pressed("move_item"):
		var index = get_index_in_grid()
		var inventory = player.inventory_array
		
		if inventory_Base_node.has_meta("ItemHeld") and inventory_Base_node.get_meta("ItemHeld"):
			# Item is being held, so swap the last clicked slot with the current one
			var last_clicked_slot = inventory_Base_node.get_meta("last_clicked_slot")
			if last_clicked_slot != null:
				# Swap the two items in the inventory array
				var temp = inventory[index]
				inventory[index] = inventory[last_clicked_slot]
				inventory[last_clicked_slot] = temp

				# Update the UI for both slots
				Slot_update(inventory[index])
				get_parent().get_child(last_clicked_slot).Slot_update(inventory[last_clicked_slot])

				# Reset the item held metadata
				inventory_Base_node.set_meta("ItemHeld", false)
				Input.set_custom_mouse_cursor(null)  # Reset cursor to default
				print("Swapped items between slots", last_clicked_slot, "and", index)
		else:
			# No item is being held, pick up the item in the current slot
			print("slot_clicked", index)
			print(inventory[index].Item_name)
			
			Input.set_custom_mouse_cursor(inventory[index].Item_Texture)
			item_visual.texture = null
			$Label.visible = false

			# Set the metadata to indicate an item is being held
			inventory_Base_node.set_meta("ItemHeld", true)
			inventory_Base_node.set_meta("last_clicked_slot", index)
			print("Item picked up from slot", index)

func get_index_in_grid() -> int:
	var parent_grid = get_parent()  # This should be the GridContainer
	for i in range(parent_grid.get_child_count()):
		if parent_grid.get_child(i) == self:
			return i
	return -1
>>>>>>> Stashed changes
