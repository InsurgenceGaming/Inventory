extends Button

@onready var Item = preload("res://Apple.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_parent().get_parent().inventory_array[1]=Item
	
