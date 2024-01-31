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

Simmilar to unity, the scene is hierarchical. The node at the very top is the 2D scene, then the three children in the scene are: A label for the menu text, a play button, and a quit button. The symbol that you see on the right side of the "Main Menu" node is a script. I've attached a script on the "Main Menu" node to control all the buttons.

So how do you make the buttons work? 
Godot has this thing called Signals. On every node, in the node section you'll have all kinds of signals which are functions that you can write in after an event has triggered. 

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/3288d0cf-3db7-43fa-b3be-f2aabeb15bba)

For example this is the signal panel from the node button "Play". I can use the signal "pressed()" by connecting it to a script like this:

![image](https://github.com/Ben-Jacks0n/Balls/assets/127924235/63a2aa08-82f3-486b-8b30-d9a2382e9085)

