extends Area2D

onready var buttonSprite = $Sprite;

func _on_Button_body_entered(body):
	var who = body.get_name()
	pressState(true, who);
func _on_Button_body_exited(body):
	var who = body.get_name()
	pressState(false, who);

func pressState(isPressed, who):
	if who == 'Player':
		if isPressed:
			buttonSprite.texture = load('res://sprites/platform_metroidvania asset pack v1.01/miscellaneous sprites/buttom_pressed.png')
		else:
			buttonSprite.texture = load('res://sprites/platform_metroidvania asset pack v1.01/miscellaneous sprites/buttom.png')	
	else: return;
