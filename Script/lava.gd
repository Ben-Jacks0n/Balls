extends Area2D

var level : Node2D

func _ready():
	level  = $".."
	
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.GameOver(body.position)
		level.isDead = true
