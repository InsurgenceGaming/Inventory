extends Button

@onready var Item_resource = preload("res://Apple.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var  inventory_array = get_parent().get_parent().inventory_array
	var Item_Instance = Item_resource.duplicate()
	for i in range(len(inventory_array)):
		if inventory_array[i].Item_name == Item_Instance.Item_name:
			var combined_total = inventory_array[i].Item_quantity + Item_Instance.Item_quantity
			if combined_total > inventory_array[i].Item_Max_quantity:
				var extra_items = combined_total - inventory_array[i].Item_Max_quantity
				inventory_array[i].Item_quantity = inventory_array[i].Item_Max_quantity
				Item_Instance.Item_quantity = extra_items
				print(inventory_array[i].Item_quantity)
			else:
				inventory_array[i].Item_quantity = combined_total
				Item_Instance.Item_quantity = 0
				print(inventory_array[i].Item_quantity)
				break
		elif inventory_array[i].Item_name == "":
			inventory_array[i] = Item_Instance
			break
			
			
	
	
