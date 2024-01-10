extends CharacterBody3D
 
@export var inventory_data: InventoryData
@export var equipment_data: InventoryData

var speed: float = 5.0
var jump_velocity: float = 4.5
var health: int = 5

@export var sens_horizontal: float = 0.5
@export var sens_vertical: float = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

 
signal toggle_inventory

@onready var camera_mount = $CameraMount
@onready var camera: Camera3D = $CameraMount/Camera3D
@onready var interact_ray = $CameraMount/Camera3D/InteractRay

func _ready() -> void:
	PlayerManager.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
 
 
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		camera_mount.rotation.x = (clamp(camera_mount.rotation.x + deg_to_rad(-event.relative.y * sens_vertical), -PI / 2 , PI / 2.1))
 
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	
	if Input.is_action_just_pressed("interact"):
		interact()
 
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
 
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
 
	move_and_slide()

func interact() -> void:
	if interact_ray.is_colliding():
		interact_ray.get_collider().player_interact()
	else:
		return

func get_drop_position() -> Vector3:
	var direction = -camera.global_transform.basis.z
	return camera.global_position + direction

func heal(heal_value: int) -> void:
	health += heal_value
