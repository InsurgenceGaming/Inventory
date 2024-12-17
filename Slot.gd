extends Panel

@onready var item_visual : Sprite2D = $Sprite2D
var sprite_following_mouse: Sprite2D


var index
var inventory
var player : Node
var inventory_Base_node : Node
func initialize(player_ref: Node, inventory_ref : Node):
	player = player_ref
	inventory_Base_node = inventory_ref
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = player.inventory_array
	inventory_Base_node.ItemHeld = false
	index = get_index_in_grid()
	pass # Replace with function body.

func Slot_update():
	if inventory[index] != null:
		item_visual.texture = inventory[index].Item_Texture
		if inventory[index].Item_quantity > 1:
			$Label.visible = true
			$Label.text = str(inventory[index].Item_quantity)
		else:
			$Label.visible = false
	else:
		item_visual.texture = null
		$Label.visible = false
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inventory_Base_node.ItemHeld && sprite_following_mouse:
		sprite_following_mouse.global_position = get_global_mouse_position()
	pass
		##inventory_Base_node.has_meta("ItemHeld") and if stuff breaks add this back before inventory_base_node.get_meta()
func _on_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_item"):
		index = get_index_in_grid()
		if inventory_Base_node.ItemHeld == true:
			print(inventory[index])
		elif inventory[index] != null:
				inventory_Base_node.ItemHeld = true
				follow_mouse_sprite()
				inventory[index] = null
				print("Item at slot ", index, " has been deleted.")
				Slot_update()
		
		
		
		
		
		
		
#		the below code is buggy as fuck at the minute
		#if ItemHeld == true:
			#print("Item Held")
			#if inventory[index]== null:
				#if sprite_following_mouse:
					#print(inventory[index])
					#Slot_update()
					#ItemHeld = false
					#sprite_following_mouse.queue_free()
				#else:
					#print("somethings fucked")
		#elif inventory[index] != null:
				#print("this inventory[index] != null on line 57",inventory[index])
			## Set the metadata to indicate an item is being held
				#ItemHeld = true
				#inventory_Base_node.set_meta("last_clicked_slot", index)
				#follow_mouse_sprite()
				#inventory[index] = null
				#print("Item at slot ", index, " has been deleted.")
				#Slot_update()
		
		
	#if Input.is_action_just_pressed("move_item"):
		#print("test")
		#
		#if inventory_Base_node.has_meta("ItemHeld") and inventory_Base_node.get_meta("ItemHeld"):
			## Item is being held, so swap the last clicked slot with the current one
			#var last_clicked_slot = inventory_Base_node.get_meta("last_clicked_slot")
			#if last_clicked_slot != null:
				## Swap the two items in the inventory array
				#var temp = inventory[index]
				#inventory[index] = inventory[last_clicked_slot]
				#inventory[last_clicked_slot] = temp
#
				## Update the UI for both slots
				#Slot_update(inventory[index])
				#get_parent().get_child(last_clicked_slot).Slot_update(inventory[last_clicked_slot])
#
				## Reset the item held metadata
				#inventory_Base_node.set_meta("ItemHeld", false)
				#Input.set_custom_mouse_cursor(null)  # Reset cursor to default
				#print("Swapped items between slots", last_clicked_slot, "and", index)
		#else:
			## No item is being held, pick up the item in the current slot
			#print("slot_clicked", index)
			#if inventory[index] != null:
				#Input.set_custom_mouse_cursor(inventory[index].Item_Texture)
				#item_visual.texture = null
				#$Label.visible = false
#
			## Set the metadata to indicate an item is being held
				#inventory_Base_node.set_meta("ItemHeld", true)
				#inventory_Base_node.set_meta("last_clicked_slot", index)
				#print("Item picked up from slot", index)
	if Input.is_action_just_pressed("split_item"):
		if inventory_Base_node.get_meta("ItemHeld"):
			print("test")
		elif inventory[index] != null and inventory[index].Item_quantity > 1:
			inventory[index].Item_quantity = inventory[index].Item_quantity/2
			Slot_update()
			Input.set_custom_mouse_cursor(inventory[index].Item_Texture)
			
func follow_mouse_sprite():
	var itemQuantity = Label.new()
	var item_resource
	sprite_following_mouse = Sprite2D.new()
	itemQuantity.text = str(inventory[index].Item_quantity)
	sprite_following_mouse.texture = inventory[index].Item_Texture
	sprite_following_mouse.position = get_global_mouse_position()
	inventory_Base_node.add_child(sprite_following_mouse)
	sprite_following_mouse.add_child(itemQuantity)
	item_resource = InvItem.new()
	item_resource.Item_Max_quantity = inventory[index].Item_Max_quantity
	item_resource.Item_name = inventory[index].Item_name
	item_resource.Item_quantity = inventory[index].Item_quantity
	item_resource.Item_Texture = inventory[index].Item_Texture
	sprite_following_mouse.set_meta("HeldItemInfo",item_resource)

	
	
func get_index_in_grid() -> int:
	var parent_grid = get_parent()  # This should be the GridContainer
	for i in range(parent_grid.get_child_count()):
		if parent_grid.get_child(i) == self:
			print("this is in get_index in grid ",i)
			return i
	return -1
