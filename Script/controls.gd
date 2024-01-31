extends Node2D

var isPressDown : bool = false 
var start_mouse_position : Vector2 = Vector2.ZERO
var end_mouse_position : Vector2 = Vector2.ZERO


var rigid_body: RigidBody2D
var line2D : Line2D
var test : Line2D

var isDead = false

@export var speed =  1500
@export var gravity = 980

var direction :Vector2
var velocity : Vector2

func _ready():
	rigid_body = $Player
	line2D = $Line2D
	test = $Line2D2


func _process(delta):
	#test.add_point(rigid_body.position)
	

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && !isDead:
		if !isPressDown:
			Engine.time_scale = 0.2
			isPressDown = true
			start_mouse_position = get_viewport().get_mouse_position()
		
		line2D.position = rigid_body.position
		end_mouse_position = get_viewport().get_mouse_position()
		direction = (end_mouse_position - start_mouse_position).normalized()
		velocity = line2D.update_trajectory(direction, speed, Vector2(0, gravity), rigid_body.mass, start_mouse_position,  end_mouse_position)
		
	elif !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && start_mouse_position != Vector2.ZERO && isPressDown && !isDead:
		Engine.time_scale = 1
		line2D.clear_points()
		
		isPressDown = false
		print("Mouse Pressed Coordinates: ", start_mouse_position)
		print("Mouse Released Coordinates: ", end_mouse_position)
		
		AddForceToPlayer()

func AddForceToPlayer():
		print("Direction: ", direction)
		rigid_body.linear_velocity = velocity
		start_mouse_position = Vector2.ZERO
		end_mouse_position = Vector2.ZERO
