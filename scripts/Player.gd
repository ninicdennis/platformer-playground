extends KinematicBody2D

export (int) var speed = 150
export (int) var jump_speed = -800
export (int) var gravity = 4000
export (int) var dash_speed = 400
export (int) var coins = 0;
const DASH_SPEED = 600

onready var animation = $AnimatedSprite;
onready var damageTimer = $DamageTimer;

var velocity = Vector2.ZERO
var dash_time = 0.2
var dash_acc = 0;

var dashing = false;
var jumping = false;
var playerHealth = 3;
var playerCanTakeDamage = true;

var currentAnim = ""
var newAnim = ""

var text = '';
var isUseActive = false;

signal on_coin_collected;
signal on_use_board;
signal leave_board;

func _ready():
	newAnim = 'idle'

func _get_input(delta):
	if playerHealth <= 0:
		get_tree().reload_current_scene()
	# Base left and right movement
	velocity.x = 0
	if !playerCanTakeDamage:
		return;
	if Input.is_action_pressed("ui_right"):
		animation.flip_h = false; 
		if jumping: newAnim = 'jump';
		else: newAnim = 'running';
		if dashing:
			velocity.x += dash_speed
		else: velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		animation.flip_h = true;
		if jumping: newAnim = 'jump';
		else: newAnim = 'running';
		if dashing:
			velocity.x -= dash_speed
		else: velocity.x -= speed
		
	# Dashing Mechanic
	if Input.is_action_just_pressed('dash') && !is_on_floor():
		dashing = true;
	if dashing:
		dash_acc += delta;
		if (is_on_floor()):
			dash_acc = 0.5
	else: jumping = false;
	
	# Jumping Mechanic
	if Input.is_action_just_pressed("ui_up"):
		jumping = true;
		newAnim='jump'
		if is_on_floor():
			velocity.y = jump_speed
	# Use Mechanic
	if Input.is_action_just_pressed('use') && isUseActive:
		emit_signal('on_use_board', text)
	elif !isUseActive:
		emit_signal('leave_board')

func _physics_process(delta):
	_get_input(delta);
	_check_animation_change();

	if dash_acc >= dash_time:
		dashing = false
		velocity = Vector2(0, 0)
		dash_acc = 0
	if dashing:
		velocity.y = gravity * delta
	else:
		velocity.y += gravity * delta 
	velocity = move_and_slide(velocity, Vector2.UP)

func _check_animation_change():
	if newAnim != currentAnim:
		print('Animation Change: ', newAnim)
		currentAnim = newAnim
		animation.play(newAnim)

func _on_TextBoard_on_allow_e_pressed(type, isActive):
	isUseActive = isActive;
	text = type;


func _on_DamageTimer_timeout():
	print('reset')
	playerCanTakeDamage = true;

func _on_AnimatedSprite_animation_finished():
	newAnim = 'idle' # Replace with function body.
