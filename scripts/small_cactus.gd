extends Area2D

@export var sprite: Sprite2D

func _ready() -> void:
	randomize()
	var region := Rect2(0, randi_range(0, 3) * 35, 17, 35)
	sprite.texture.region = region
	
func _process(delta: float) -> void:
	if Globals.started:
		position.x -= Globals.speed * delta
		
	if global_position.x < -100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	Globals.dead = true
