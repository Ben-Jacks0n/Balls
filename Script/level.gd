extends Node2D

var isPressDown = false
var start_mouse_position = Vector2.ZERO
var rigid_body: RigidBody2D


var isDead = false



func _ready():
	rigid_body = $RigidBody2D

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && !isPressDown && !isDead:
		isPressDown = true
		start_mouse_position = get_global_mouse_position()
		
		
	elif !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && start_mouse_position != Vector2.ZERO && isPressDown && !isDead:
		isPressDown = false
		var end_mouse_position = get_global_mouse_position()
		# Print the coordinates when pressed and released
		print("Mouse Pressed Coordinates: ", start_mouse_position)
		print("Mouse Released Coordinates: ", end_mouse_position)
		
		AddForceToBall(start_mouse_position, end_mouse_position)
		


func AddForceToBall(start_mouse_position, end_mouse_position):
		var direction = -(end_mouse_position - start_mouse_position).normalized()

		print("Direction: ", direction)
		
		#remove any forces to 0
		rigid_body.linear_velocity = Vector2.ZERO
		rigid_body.angular_velocity = 0.0
		
		# Add force to the rigid body
		var force_strength =  1700.0# Adjust the force strength as needed

	
		rigid_body.apply_central_impulse(direction * force_strength)

		# Reset start position for the next press/release cycle
		start_mouse_position = Vector2.ZERO
