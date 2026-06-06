class_name Dino
extends CharacterBody2D
enum States {IDLE, RUNNING, DUCK, DEAD, JUMPING, FALLING}

@onready var sprite := $AnimatedSprite2D
@onready var upper_collision := $UpperCollision
@onready var duck_head := $DuckHead

@export var jump_force: float = 600 
@export var base_gravity: float = 32
@export var jump_gravity: float = 22
@export var duck_gravity: float = 120.0

var cur_gravity := base_gravity 
  
var state: States = States.IDLE 
var jumping: bool = false

func _physics_process(delta: float) -> void:
	print(Globals.started, " ", Globals.dead  )
	if not is_on_floor() and state != States.DEAD and Globals.started:
		velocity += Vector2(0, cur_gravity*100) * delta
	
	if Globals.started and state != States.DEAD:
		if Globals.dead:
			set_state(States.DEAD)
		elif is_on_floor() and Input.is_action_pressed("jump") and state != States.DUCK:
			set_state(States.JUMPING)
		elif Input.is_action_pressed("duck"):
			set_state(States.DUCK)
		elif not is_on_floor() and velocity.y > 0:
			set_state(States.FALLING)
		elif is_on_floor():
			set_state(States.RUNNING) 
	update_state()
	move_and_slide()

func set_state(new_state: int) -> void:
	var prev_state := state
	state = new_state
	
	if state == prev_state: return
	
	match prev_state:
		States.DUCK: 
			cur_gravity = base_gravity
			upper_collision.disabled = false
			duck_head.disabled = true
	
	match state:
		States.IDLE: sprite.play("idle")
		
		States.RUNNING: sprite.play("run")
		
		States.JUMPING:
			sprite.play("idle")
			velocity.y -= jump_force 
			jumping = true
			
		States.FALLING:
			sprite.play("idle")
			cur_gravity = base_gravity
			
		States.DUCK: cur_gravity = duck_gravity
			
		States.DEAD: 
			sprite.play("dead")
			print("MORRI")

func update_state() -> void:
	match state:
		States.JUMPING:
			if Input.is_action_pressed("jump") && jumping:
				cur_gravity = jump_gravity
			else:
				jumping = false
				cur_gravity = base_gravity
		States.DUCK:
			if not is_on_floor():
				sprite.play("idle")
			elif sprite.animation != "duck":
				upper_collision.disabled = true
				duck_head.disabled = false
				sprite.play("duck")
