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
	
	
	
	
