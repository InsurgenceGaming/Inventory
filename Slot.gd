extends Panel

@onready var item_visual : Sprite2D = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Slot_update(item:InvItem):
	if item:
		item_visual.texture = item.Item_Texture
		print("i ran")
		$Label.text = str(item.Item_quantity)
	else:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
