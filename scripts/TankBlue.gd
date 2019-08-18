extends KinematicBody2D

const MOVE_SPEED = 400
const ROTATE_SPEED = PI

var TankBlueBullet = preload("res://scenes/TankBlueBullet.tscn")

const HEALTH_MAX = 100
var health = HEALTH_MAX

func adjust_health(health_adjustment):
	health += health_adjustment
	if health < 0:
		health == 0
	if health > HEALTH_MAX:
		health == HEALTH_MAX
	$HealthBar.set_health(health, HEALTH_MAX)
	if health <= 0:
		get_tree().quit()

func _process(delta):
	var movement = Vector2()
	if Input.is_action_pressed("move_tank_forward"):
		movement.y = MOVE_SPEED * delta
	if Input.is_action_pressed("move_tank_backwards"):
		movement.y = -MOVE_SPEED * 0.5 * delta
	if Input.is_action_pressed("rotate_tank_left"):
		rotate(-ROTATE_SPEED * delta)
	if Input.is_action_pressed("rotate_tank_right"):
		rotate(ROTATE_SPEED * delta)
	move_and_collide(movement.rotated(rotation))
	
	if Input.is_action_just_pressed("tank_shoot") and $Timer.time_left == 0:
		var newTankBlueBullet = TankBlueBullet.instance()
		newTankBlueBullet.position = position + $TankBlueGun.position.rotated(rotation)
		newTankBlueBullet.rotation = rotation + $TankBlueGun.rotation
		get_node("../../Bullets").add_child(newTankBlueBullet)
		$Timer.start()
	
	$TankBlueGun.rotation = atan2(get_global_mouse_position().y - position.y, get_global_mouse_position().x - position.x) + PI / 2 - rotation