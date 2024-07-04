extends RigidBody2D
@export var inventory : PackedScene
var direction = Vector2.ZERO
var InventoryData
# Called when the node enters the scene tree for the first time.
func _ready():
	if InventoryData == null:
		self.set_meta("inventory_open",false)
		InventoryData = true
func _physics_process(delta):
	linear_velocity = 100 * direction
func _input(event):
	if Input.is_action_pressed("ui_left")&& !get_meta("inventory_open"):
		direction = Vector2.LEFT
	elif  Input.is_action_pressed("ui_right")&&!get_meta("inventory_open"):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#this code is to manage the opening of the inventory and prevents the player from opening multiple instances
	#Possibly swap to MetaData to make sure the inventory isnt open to avoid directly modifying the
	#code for the player
	
	if Input.is_action_just_pressed("ui_down") && !get_meta("inventory_open"):
		set_meta("inventory_open",true)
		var new_inventory = inventory.instantiate()
		get_node("CanvasLayer").add_child(new_inventory)
		print("i should open")
		
		
		
