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
