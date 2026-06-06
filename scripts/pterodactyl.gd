extends Area2D

@onready var sprite := $AnimatedSprite2D

func _ready() -> void:   
	sprite.play("default")
	var pos := randi_range(0, 2)
	
	match pos:
		2: position.y -= 2
		1: position.y -= 30   
		_: position.y -= 60
	
func _process(delta: float) -> void:
	if Globals.started:
		position.x -= Globals.speed * delta
	if Globals.dead:
		sprite.pause()
		
	if global_position.x < -100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	Globals.dead = true
	print("COLLIDED 1") 
