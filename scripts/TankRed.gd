extends KinematicBody2D

var TankRedBullet = preload("res://scenes/TankRedBullet.tscn")

const HEALTH_MAX = 100
var health = 4

func _ready():
	$HealthBar.set_health(health, HEALTH_MAX)

func adjust_health(health_adjustment):
	health += health_adjustment
	if health < 0:
		health == 0
	if health > HEALTH_MAX:
		health == HEALTH_MAX
	$HealthBar.set_health(health, HEALTH_MAX)
	if health <= 0:
		queue_free()

var movement = Vector2()

func _process(delta):
	movement.y += (randi() % 20 - 10) 
	if movement.y < -400:
		movement.y = -400
	if movement.y > 400:
		movement.y = 400
	rotate(float(randi() % 2 - 4) / 100)
	move_and_collide(movement.rotated(rotation) * delta)
	
	if randi() % 25 == 1 and $Timer.time_left == 0:
		var newTankRedBullet = TankRedBullet.instance()
		newTankRedBullet.position = position + $TankRedGun.position.rotated(rotation)
		newTankRedBullet.rotation = rotation + $TankRedGun.rotation
		get_node("../../Bullets").add_child(newTankRedBullet)
		$Timer.start()
	
	$TankRedGun.rotate(float(randi() % 2 - 4) / 50)
