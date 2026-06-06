extends Node2D

@export var ground : Parallax2D 

func _process(delta: float) -> void: 
	print(Globals.score)
	if not Globals.started and Input.is_action_just_pressed("jump"):
		Globals.started = true
		 
	var increment = 1 + Globals.score / 120.0  
	Globals.speed = min(Globals.score / 2 + 400, 1000)
	
	if Globals.started and not Globals.dead:
		Globals.score += increment * delta
		ground.autoscroll.x = -Globals.speed
	if Globals.dead:
		ground.autoscroll.x = 0
		Globals.speed = 0
