extends Panel

@onready var item_visual : Texture = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Slot_update(item:InvItem):
	if item:
		item_visual = item.Item_Texture
		print("i ran")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
