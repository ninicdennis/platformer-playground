extends Area2D

func _ready():
	pass

func _on_Coin_body_entered(body):
	body.coins += 1
	body.emit_signal('on_coin_collected')
	queue_free()
