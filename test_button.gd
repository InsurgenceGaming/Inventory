extends Button

@onready var Item = preload("res://Apple.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var  inventory_array = get_parent().get_parent().inventory_array
	for i in range(len(inventory_array)):
		if inventory_array[i].Item_name == "":
			inventory_array[i] = Item
			break
			
			
	
	
