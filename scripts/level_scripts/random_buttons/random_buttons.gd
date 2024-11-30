extends Node2D

var rng = RandomNumberGenerator.new()


@export var all_buttons: Array[Node2D]
@export var play_button: Node2D
var button_with_play_func: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	assign_play_func()

func assign_play_func():
	if(len(all_buttons)<=0):
		return
	while true:
		var random_button:Node2D = all_buttons[rng.randi_range(0,len(all_buttons)-1)]
		if random_button!=play_button:
			button_with_play_func = random_button
			break
			
	for button in all_buttons:
		if(button == button_with_play_func):
			button.pressed.connect(func(): SceneManager.next_level())
		else:
			button.pressed.connect(show_wrong_button_quote)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_wrong_button_quote():
	$Wrong_button_text_dis.start_printing()
