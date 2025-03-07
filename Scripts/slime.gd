extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null
var current_dir = "none"
# var direction = (player.position - position).normalized()

var health = 100
var player_in_attackzone = false

func _ready():
	$AnimatedSprite2D.play("idle_front")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func _physics_process(delta):
	deal_with_damage()
	
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

func enemy():
	pass
	

func _on_slime_hit_box_body_entered(body):
	if body.has_method("player"):
		player_in_attackzone = true

func _on_slime_hit_box_body_exited(body):
	if body.has_method("player"):
		player_in_attackzone = false

func deal_with_damage():
	if player_in_attackzone and Global.player_current_attack == true:
		health = health - 20
		print("slime health = ", health)
		if health <= 0:
			$AnimatedSprite2D.play("death")
			self.queue_free()
