extends Area2D

signal update_health;

func _ready():
	pass

func _on_Spikes_body_entered(body):
	var who = body.get_name();
	if who == 'Player':
		if body.playerCanTakeDamage:
			print('Player entered')
			body.playerHealth -= 1;
			body.damageTimer.start();
			body.playerCanTakeDamage = false;
			print(body.velocity)
			# body.velocity =  Vector2(body.velocity.x * -1, body.velocity.y * -1); # Velocity reversal
			body.velocity =  Vector2(body.velocity.x * -1, body.velocity.y * -1); # Velocity reversal
			print(body.velocity)
			body.newAnim = 'hurt'
			emit_signal('update_health')
