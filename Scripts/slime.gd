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
		
		if abs(direction.x) > abs(direction.y): 
			# More horizontal movement
			if direction.x < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("moving_side")
		else:
			# More vertical movement
			if direction.y < 0:
				$AnimatedSprite2D.play("moving_back")
			else:
				$AnimatedSprite2D.play("moving_front")
		
		move_and_slide()
	else:
		$AnimatedSprite2D.play("idle_front")
	
