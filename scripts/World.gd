extends Node

onready var player = $Player;
onready var coin_text = $UI/CoinCount;
onready var text_dialog = $UI/TextDialog/Text;
onready var health_text = $UI/Hearts/PlayerHealth;

func _ready():
	text_dialog.visible = false;
	health_text.text = 'Health: ' + str(player.playerHealth);
	
func _on_Player_on_coin_collected():
	print('Collected coin!');
	coin_text.text = str(player.coins)

func _on_Player_on_use_board(text):
	print('Used board!', text)
	text_dialog.text = text;
	text_dialog.visible = true;

func _on_Player_leave_board():
	text_dialog.visible = false;


func _on_Spikes_update_health():
	print('Damage taken: ', player.playerHealth)
	health_text.text = 'Health: ' + str(player.playerHealth);
