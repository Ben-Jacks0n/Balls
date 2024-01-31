# Balls
Recreation of the game "Balls?" made by dani for practice.

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/9a925a8d-c63f-4218-b818-f729a6272fb7)

Last edited: 1/31/2024 10:16pm
Currently its just the core mechanics of shooting the ball and hitting the red ball targets. This is for beter understanding the 2D Physics and the godot workflow.

## Play Instructions
* Clone or download the project
* Run godot engine
* Click Import
* Choose the file path to the project
* After the scene is loaded, on the right hand corner click the play button

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/dcf77fc8-7578-4f26-87d5-ad7c004adcb4)

## Introduction
This project is a 2D project to recreate the game "Balls?". The purpose of this project is to learn the basics of godot. After the Unity scandal I felt that its time to switch to godot. From what I've experienced the engine is beginer friendly and easy to uderstand. Now i just need to practice more so that I have a better and faster workflow. The godot engine although cannot be compared to unity becase it has i'ts own system and it's not in any way a one to one replacement of unity. 

The first time you make a new project in godot you see this

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/6402a788-56e2-49cb-9a69-71171b0c7a79)

Forward+ just means it's for 3D projects, Mobile means it's for 2D projects, and compatibility is experimental (idk yet)

The game is just compiled from 2 scenes: main_menu the_level.

## Main Menu
![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/7b89b1be-e4c3-4ca9-a779-e9159bd767ce)

The main menu is just comprised of text and two buttons play and quit. Everything from the scene is made up of nodes. 

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/15cfa355-f82e-4efc-b283-bed26fcbc442)

Simmilar to unity, the scene is hierarchical. The node at the very top is the 2D scene, then the three children in the scene are: A label for the menu text, a play button, and a quit button. The symbol that you see on the right side of the "Main Menu" node is a script. I attached a script on the "Main Menu" node to control all the buttons.

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

The player node I saved it to a folder. You can do this to any node by right clicking a node and choose "Save Branch as Scene" this will store the node into a folder that can be reused simmilar to a prefab in unity.

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/ff652cbd-3595-4bf7-b122-5e1e0e1cbc5d)

Ive attached a camera node in the player so it can track the player. 

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/94affdbc-3fe6-4f21-a9a5-749ca7e99952)

Ive also made a grup called "Player" for the player. This is simmilar to tags in unity and it will be usefull later

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/a827989d-c266-4cdd-9173-5f2ad2468a7b)


And lastly the player has a GameOver button. When triggered it will record the position to the deathPos node. Then it will change the camera parent to the deathPos, despawn the player and spawn the game over text and the game over buttons as children of the camera.

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
There are many nodes that you can use to create an environment but I only used two tipes of nodes which are StaticBody2D and Area2D. The StaticBody2D is used for platforms to stand on. It is also required to have a collision and a mesh as children.

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/1b99f81f-75ec-4ed9-b2f3-a5c38418f6a3)

Now the Area2D is used for the lava to kill the player. Since it doesn't need to interact with the player like bouncing or other physics, I used the Area2D which only checks if an object has entered the area. But Area2D nodes still required to have a collision and a mesh as children.

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/b8375ff3-46a9-4428-bf3a-c8a1d6534c83)

Then I attached a script to the lava that checks if an object with the tag "Player" has entered the area then it will trigger the script GameOver() in the current player position

```GCScript
extends Area2D

var level : Node2D

func _ready():
	level  = $".."
	
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.GameOver(body.position)
		level.isDead = true

```



