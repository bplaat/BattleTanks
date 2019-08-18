extends Area2D

const MOVE_SPEED = 800
var speed = MOVE_SPEED

func _process(delta):
	move_local_y(-speed * delta)

func _on_TankRedBullet_body_entered(body):
	if body.get_name().find("TankRed") == -1:
		if body.get_name().find("Tank") != -1:
			body.adjust_health(-(randi() % 15 + 5))
		explode()

func _on_Timer_timeout():
	explode()

func explode():
	speed = 0
	$BulletFire.visible = false
	$TankRedBullet.visible = false
	$ExplodeAnimation.visible = true
	$ExplodeAnimation.play()

func _on_ExplodeAnimation_animation_finished():
	queue_free()
