extends Control
## Define things on scene creation
@onready var slot = preload("res://UI/Slot.tscn")
## definre variables
var sprite_following_mouse: Sprite2D
var draggingDistance
var dir
var dragging
var newposition
var mouse_in = false
var player : Node
func initialize(player_ref: Node):
	player = player_ref

func follow_mouse_sprite():
	var itemQuantity = Label.new()
	var item_in_hand:InvItem
	sprite_following_mouse = Sprite2D.new()
	sprite_following_mouse.texture = null
	$".".add_child(sprite_following_mouse)
	sprite_following_mouse.add_child(itemQuantity)
	sprite_following_mouse.name = "cursor"
	print(sprite_following_mouse.name)
	
	
func _ready():
	if $Panel/GridContainer.get_children().is_empty():
		for i in player.get_meta("Inventory_size"):
			var new_slot = slot.instantiate()
			new_slot.initialize(player,$".")
			$Panel/GridContainer.add_child(new_slot)
		
	var slots: Array = $Panel/GridContainer.get_children()
	for i in range(min(player.get_meta("Inventory_size").size(),slots.size())):
		slots[i].Slot_update()
	follow_mouse_sprite()
	set_meta("ItemHeld", false)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $".".get_meta("ItemHeld",true):
		if sprite_following_mouse:
			get_node("cursor").global_position = get_global_mouse_position()
		else: 
			pass
	pass
	if dragging:
		position = newposition

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in && !get_meta("ItemHeld"):
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			newposition = get_viewport().get_mouse_position() - draggingDistance * dir
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and InputEventMouseButton:
		if dragging:
			newposition = get_viewport().get_mouse_position() - draggingDistance * dir

func _on_button_pressed():
	get_parent().get_parent().set_meta("inventory_open",false)
	player.set_meta("inventory_open",false)
	if get_meta("ItemHeld") == true:
		Input.set_custom_mouse_cursor(null)
		set_meta("ItemHeld",false)
		print(get_meta("ItemHeld"))
	self.queue_free()
	

func _on_panel_2_mouse_entered():
	mouse_in = true


func _on_panel_2_mouse_exited():
	mouse_in = false
