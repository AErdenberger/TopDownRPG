extends CharacterBody2D

const speed = 100
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("idle_front")

func player_animation(movement):
	var dir = current_dir
	var animation = $AnimatedSprite2D
	
	if dir == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_side")
		else:
			animation.play("idle_side")
	elif dir == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_side")
		else:
			animation.play("idle_side")
	elif dir == "up":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_back")
		else:
			animation.play("idle_back")
	elif dir == "down":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_front")
		else:
			animation.play("idle_front")

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		player_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		player_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		player_animation(1)
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		player_animation(1)
		velocity.x = 0
		velocity.y = speed
	else:
		player_animation(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
