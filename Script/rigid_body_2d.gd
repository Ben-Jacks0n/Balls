extends Node2D


var camera : Camera2D
var deathPos : Node2D
var gameOverText = preload("res://Prefab/GameOverText.tscn")
var gameOverButtons = preload("res://Prefab/game_over_buttons.tscn")

func _ready():
	camera = $Camera2D
	deathPos = $"../DeathPos"


func GameOver(pos):
	print("GameOver")
	deathPos.position = pos
	
	var player = camera.get_parent()
	player.remove_child(camera)
	deathPos.add_child(camera)
	player.queue_free()
	
	
	camera.position.y -= 40
	var object = gameOverText.instantiate()
	var buttonsObjet = gameOverButtons.instantiate()
	camera.add_child(object)
	camera.add_child(buttonsObjet)
	
	
	
	
