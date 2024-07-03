extends RigidBody2D
var inventory_open:bool = false
@export var inventory : PackedScene
var direction = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _physics_process(delta):
	linear_velocity = 100 * direction
func _input(event):
	if Input.is_action_pressed("ui_left") and !inventory_open:
		direction = Vector2.LEFT
	elif  Input.is_action_pressed("ui_right") and !inventory_open:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#this code is to manage the opening of the inventory and prevents the player from opening multiple instances
	#Possibly swap to MetaData to make sure the inventory isnt open to avoid directly modifying the
	#code for the player
	
	if Input.is_action_just_pressed("ui_down") && !inventory_open:
		inventory_open = true
		var new_inventory = inventory.instantiate()
		get_node("CanvasLayer").add_child(new_inventory)
		print("i should open")
		
		
		
