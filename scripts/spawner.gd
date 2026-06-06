extends Node2D

const BIG_CAC = preload("res://scenes/big_cactus.tscn")
const BIG_CAC_2 = preload("res://scenes/big_cactus_2.tscn")
const BIG_CAC_3 = preload("res://scenes/big_cactus_3.tscn")
const SMALL_CAC = preload("res://scenes/small_cactus.tscn")
const SMALL_CAC_2 = preload("res://scenes/small_cactus_2.tscn")
const SMALL_CAC_3 = preload("res://scenes/small_cactus_3.tscn")
const PTERODACTYL = preload("res://scenes/pterodactyl.tscn")

enum Levels {CACTUS, CACTI, FLYING, CAC3TI}

@onready var timer: Timer = $Timer
var level: Levels = Levels.CACTUS

var cactus_obj = [SMALL_CAC, BIG_CAC]
var cactus_w = [1.2, 1]
var cacti_obj = [SMALL_CAC, BIG_CAC, SMALL_CAC_2, SMALL_CAC_3]
var cacti_w = [1.2, 1, 0.3, 0.2]
var fly_obj = [SMALL_CAC, BIG_CAC, PTERODACTYL, SMALL_CAC_2, SMALL_CAC_3, BIG_CAC_2]
var fly_w = [1.2, 1, 0.7, 0.4, 0.2, 0.2]
var cac3ti_obj = [SMALL_CAC, BIG_CAC, PTERODACTYL, SMALL_CAC_2, SMALL_CAC_3, BIG_CAC_2, BIG_CAC_3]
var cac3ti_w = [1.2, 1, 0.9, 0.5, 0.3, 0.2, 0.2]

@onready var random = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	var score : int = floor(Globals.score*10)
	print(score)
	if score > 2000:
		level = Levels.CAC3TI
	elif score > 1000:
		level = Levels.FLYING
	elif score > 500:
		level = Levels.CACTI
	else:
		level = Levels.CACTUS

func spawn_obs(obj: PackedScene):
	var cac_instance = obj.instantiate()
	cac_instance.global_position = self.global_position
	cac_instance.position = Vector2(0, 0)
	add_child(cac_instance)
	print("SPAWNED")


func _on_timer_timeout() -> void:
	var mod = randf()
	match level:
		Levels.CACTUS:
			spawn_obs(cactus_obj[random.rand_weighted(cactus_w)])
			print("CACTUS")
		Levels.CACTI:
			spawn_obs(cacti_obj[random.rand_weighted(cacti_w)])
			print("CACTI")
		Levels.FLYING:
			spawn_obs(fly_obj[random.rand_weighted(fly_w)])
			print("FLY") 
		Levels.CAC3TI:
			spawn_obs(cac3ti_obj[random.rand_weighted(cac3ti_w)])
			print("CAC3TI")
	timer.wait_time = 0.5 + 0.5*mod
