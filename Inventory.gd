extends Control

var mouse_in = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			print("yo")

func _on_button_pressed():
	get_parent().get_parent().set_meta("inventory_open",false)
	self.queue_free()
	

func _on_panel_2_mouse_entered():
	mouse_in = true


func _on_panel_2_mouse_exited():
	mouse_in = false
