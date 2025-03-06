extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("idle_front")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
	
		$AnimatedSprite2D.play("moving_front")
	else:
		$AnimatedSprite2D.play("idle_front")
	
