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
