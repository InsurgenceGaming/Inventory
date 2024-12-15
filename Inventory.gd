extends Control

var mouse_in = false
@onready var slot = preload("res://UI/Slot.tscn")
# Called when the node enters the scene tree for the first time.
var player : Node
func initialize(player_ref: Node):
	player = player_ref
	
	
func _ready():
	if $Panel/GridContainer.get_children().is_empty():
		for i in player.get_meta("Inventory_size"):
			var new_slot = slot.instantiate()
			new_slot.initialize(player,$".")
			$Panel/GridContainer.add_child(new_slot)
		
	var slots: Array = $Panel/GridContainer.get_children()
	for i in range(min(player.get_meta("Inventory_size").size(),slots.size())):
		slots[i].Slot_update(player.get_meta("Inventory_size")[i])
		
		
	
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			print("yo")

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
