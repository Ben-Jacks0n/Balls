# Balls
Recreation of the game "Balls?" made by dani for practice.

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/9a925a8d-c63f-4218-b818-f729a6272fb7)

Last edited: 1/31/2024 10:16pm
Currently it's just the core mechanics of shooting the ball and hitting the red ball targets. This is for better understanding the 2D Physics and the godot workflow.

## Play Instructions
* Clone or download the project
* Run godot engine
* Click Import
* Choose the file path to the project
* After the scene is loaded, on the right hand corner click the play button

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/dcf77fc8-7578-4f26-87d5-ad7c004adcb4)

## Introduction
This project is a 2D project to recreate the game "Balls?". The purpose of this project is to learn the basics of godot. After the Unity scandal I felt that it's time to switch to godot. From what I've experienced the engine is beginner friendly and easy to understand. Now I just need to practise more so that I have a better and faster workflow. The godot engine although cannot be compared to unity because it has its own system and it's not in any way a one to one replacement of unity.  

The first time you make a new project in godot you see this

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/6402a788-56e2-49cb-9a69-71171b0c7a79)

Forward+ just means it's for 3D projects, Mobile means it's for 2D projects, and compatibility is experimental (idk yet)

The game is just compiled from 2 scenes: main_menu and level.

## Main Menu
![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/7b89b1be-e4c3-4ca9-a779-e9159bd767ce)

The main menu is just comprised of text and two buttons play and quit. Everything from the scene is made up of nodes. 

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/15cfa355-f82e-4efc-b283-bed26fcbc442)

Similar to unity, the scene is hierarchical. The node at the very top is the 2D scene, then the three children in the scene are: A label for the menu text, a play button, and a quit button. The symbol that you see on the right side of the "Main Menu'' node is a script. I attached a script on the "Main Menu'' node to control all the buttons.

So how do you make the buttons work? 
Godot has this thing called Signals. On every node, in the node section you'll have all kinds of signals which are functions that you can write in after an event has triggered. 

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/3288d0cf-3db7-43fa-b3be-f2aabeb15bba)

For example this is the signal panel from the node button "Play". I can use the signal "pressed()" by connecting it to a script like this:

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/63a2aa08-82f3-486b-8b30-d9a2382e9085)

By connecting the signal to a script. It will give you a function in the script that you can write and execute if the conditions are met. Functions for the buttons are pretty simple. If the player pressed play it will change scene to the level, and if they pressed quit it will quit the application.

```GDScript
extends Node2D

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/level.tscn")

func _on_quit_pressed():
	get_tree().quit()	

```


## Level
![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/0b30eb90-c6de-4bcc-a0cb-b5430c17387c)

The level ill break it down into 4 parts that are: the player, the environment, the launch mechanic, and the red ball.

### The Player
The player is a RigidBody2D node with MeshInstance2D for the color and the CollisionShape2D for it to collide.

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/f1d75d25-1a08-4a43-b0b5-6f11f8f34e8a)

The player node I saved to a folder. You can do this to any node by right clicking a node and choose "Save Branch as Scene '' this will store the node into a folder that can be reused, similar to a prefab in unity.

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/ff652cbd-3595-4bf7-b122-5e1e0e1cbc5d)

I attached a camera node in the player so it can track the player. 

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/94affdbc-3fe6-4f21-a9a5-749ca7e99952)

I also made a group called "Player" for the player. This is similar to tags in unity and it will be useful later

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/a827989d-c266-4cdd-9173-5f2ad2468a7b)


And lastly the player has a GameOver button. When triggered it will record the position to the deathPos node. Then it will change the camera parent to the deathPos, despawn the player and spawn the game over text and the game over buttons as children of the camera. The line2D.clear_points() will be useful for later.
```GDScript
extends Node2D

var camera : Camera2D
var deathPos : Node2D
var gameOverText = preload("res://Prefab/GameOverText.tscn")
var gameOverButtons = preload("res://Prefab/game_over_buttons.tscn")
var line2D : Line2D

func _ready():
	camera = $Camera2D
	deathPos = $"../DeathPos"
	line2D = $"../Line2D"

func GameOver(pos):
	print("GameOver")
	line2D.clear_points()

	deathPos.position = pos
	
	var player = camera.get_parent()
	player.remove_child(camera)
	deathPos.add_child(camera)
	player.get_parent().remove_child(player)
	
	
	camera.position.y -= 40
	var object = gameOverText.instantiate()
	var buttonsObjet = gameOverButtons.instantiate()
	camera.add_child(object)
	camera.add_child(buttonsObjet)
```

### The Environment
There are many nodes that you can use to create an environment but I only used two types of nodes which are StaticBody2D and Area2D. The StaticBody2D is used for platforms to stand on. It is also required to have a collision and a mesh as children.

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/1b99f81f-75ec-4ed9-b2f3-a5c38418f6a3)

Now the Area2D is used for the lava to kill the player. Since it doesn't need to interact with the player like bouncing or other physics, I used the Area2D which only checks if an object has entered the area. But Area2D nodes are still required to have a collision and a mesh as children.

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/b8375ff3-46a9-4428-bf3a-c8a1d6534c83)

Then I attached a script to the lava that checks if an object with the tag "Player" has entered the area then it will trigger the script GameOver() in the current player position. the level.isDead = true will be useful for later.

```GDScript
extends Area2D

var level : Node2D

func _ready():
	level  = $".."
	
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.GameOver(body.position)
		level.isDead = true

```

### The Launch Mechanic
The launch mechanic pretty much boils down to record the coordinates when the left mouse is first clicked, record the coordinates when the left mouse is released, and launch the player to that direction. The control script is attached to the level. Here is the full code.
```GDScript
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
```

Firstly I have the player rigidbody declared and assigned in the function _ready(): two main booleans: "isPressDown" and "isDead" mentioned in the The Environment section and also two vectors for start and end positions.

```GDScript
var isPressDown : bool = false
var start_mouse_position : Vector2 = Vector2.ZERO
var end_mouse_position : Vector2 = Vector2.ZERO
var isDead = false

var rigid_body: RigidBody2D
var line2D : Line2D

func _ready():
	rigid_body = $Player
	line2D = $Line2D
```

In the process function I checked if the left mouse button is being pressed and if the player is not dead. If both are true then I also check if it is currently pressed down. If it has not then I will set it to slowmo by changing the time scale to 0.2, set the isPressedDown to true, and record the start_mouse_position. The reason I used the bool isPressDown is so that I can record the start mouse position only once until the user lets go of the left mouse.

I record the end mouse position while the if statement is true, calculate the direction and the velocity. (note that I recorded the start position from the screen position and not the game world position). This will constantly record the end position and calculate velocity until the if statement is no longer true.

```GDScript
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && !isDead:
		if !isPressDown:
			Engine.time_scale = 0.2
			isPressDown = true
			start_mouse_position = get_viewport().get_mouse_position()
		
		line2D.position = rigid_body.position
		end_mouse_position = get_viewport().get_mouse_position()
		direction = (end_mouse_position - start_mouse_position).normalized()
		velocity = line2D.update_trajectory(direction, speed, Vector2(0, gravity), rigid_body.mass, start_mouse_position,  end_mouse_position)
```


The "line2D.position = rigid_body.position" and the "velocity = line2D.update_trajectory(direction, speed, Vector2(0, gravity), rigid_body.mass, start_mouse_position,  end_mouse_position)" is used for this script that is attached to line2D 

```GDScript
extends Line2D

func _ready() -> void:
	pass

func update_trajectory(dir: Vector2, speed: float, gravity: Vector2, mass : float, start_mouse_position: Vector2, end_mouse_position: Vector2 ):
	var max_points = 50
	clear_points()
	var pos: Vector2 = Vector2.ZERO
	var vel = dir * speed
	
	add_point(pos)
	var dist = (end_mouse_position - start_mouse_position) * 3
	pos += dist
	add_point(pos)
	
	
	#for i in range(max_points):
		#add_point(pos)
		#var t = i * 0.05 
		#pos = vel * t + gravity * 0.5 *  t** 2
	
	return vel
```

The script above returns the velocity calculated by speed times direction. This function was originally used to add a trajectory line for the player but it is not accurate at the moment and it is replaced with a straight line

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/7f2ad77a-a997-4bd1-9396-d71492da2f69)


Now back to the main script. I made an else if statement that checks if the user no longer holds the mouse button, the start mouse position was recorded, the isPressDown is true, and the player is not dead, then we stop the slow motion, clear any lines, set the isPressedDown bool to false and finally add force to the player.

```GDScript
	elif !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && start_mouse_position != Vector2.ZERO && isPressDown && !isDead:
		Engine.time_scale = 1
		line2D.clear_points()
		
		isPressDown = false
		print("Mouse Pressed Coordinates: ", start_mouse_position)
		print("Mouse Released Coordinates: ", end_mouse_position)
		
		AddForceToPlayer()
```
Since I already calculated the velocity, i can just change the players velocity to the calculated velocity then change the start and end position back to zero for the next cycle.
```GDScript
func AddForceToPlayer():
		print("Direction: ", direction)
		rigid_body.linear_velocity = velocity
		start_mouse_position = Vector2.ZERO
		end_mouse_position = Vector2.ZERO
```

### The Red Ball

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/c230b831-b28c-4e92-ae36-40fa7388d90d)

The red ball is pretty simple, It's just an area2D node with a script attached. The script checks if an object with the tag "Player" has entered the ball, then it will dampen the x linear velocity to 0.3 and remove the y linear velocity and apply impulse upwards.

```GDScript
extends Area2D


var rb : RigidBody2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("test")
		rb = body
		rb.linear_velocity.x *= 0.3
		rb.linear_velocity.y = 0
		rb.apply_central_impulse(Vector2(0, -900))
	
	self.queue_free()
```

## Conclusion
This is a practice project for better understanding the concept of godot. Ive learned alot from this little project alone from Nodes, signals, groups to prefabs and how to attach scripts. Of Course there is still a lot to learn and a lot to be done like making a point system etc. Although I have some concerns with the 2D physics when calculated is not accurate and the coordinate system is backwards. plus y is down and minus y is up. Hopefully I can learn to overcome this and master it in future projects.
