extends Area2D

onready var UseLabel = $UseLabel

export var text = ''

signal on_allow_e_pressed;

func _ready():
	UseLabel.visible = false;

func _on_TextBoard_body_entered(body):
	var who = body.get_name();
	if who == 'Player':
		print('Entered')
		UseLabel.visible = true;
		emit_signal('on_allow_e_pressed', text, true)

func _on_TextBoard_body_exited(body):
	var who = body.get_name();
	if who == 'Player':
		print('Exited')
		UseLabel.visible = false;
		emit_signal('on_allow_e_pressed', '', false)
