extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
var current_dir = "none"
# var direction = (player.position - position).normalized()

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
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		
		move_and_slide()
	
		$AnimatedSprite2D.play("moving_front")
	else:
		$AnimatedSprite2D.play("idle_front")
	
