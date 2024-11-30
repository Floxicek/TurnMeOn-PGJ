extends Node2D

var rng = RandomNumberGenerator.new()

var shown_text = ""
@export var dialogue: Array[String] = ["Sample text"]
@export var time_between_letters = 0.2
@export var time_between_dialogues = 1
@export var wait_before_hide:float = 3
@export var hide_afterwards:bool = false
@export var loop_dialogue:bool = false

var text_complete:bool = false

var cur_text:String = "Sample text"

var single_word:bool = false

var cur_text_index:int = 0

var wrong_button_dialogue:Array[String] = ["Nope, not this one.",
"Nope, nope, nopity, nope.",
"No.",
"This button isn’t giving.",
"Not slay. ",
"Nuh-uh.",
"Nice try but no.",
"That’s the wrong button.",
"That’s the wrong button again.",
"Not this one! Look again!"]
#"This be not the proper button, oh thou mighty knight.",
#"This be not the path to progress, thou mighty knight.",
#"Attempt a different path, oh thou sorcerer of the machine."]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Next_letter_timer.wait_time = time_between_letters
	$Next_word_timer.wait_time = time_between_dialogues
	shown_text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = shown_text
	
	
func show_rand_bad_button_dialog():
	start_printing_single_word(wrong_button_dialogue[rng.randi_range(0,len(wrong_button_dialogue)-1)])
	
	
func start_printing_single_word(text:String, custom_time_to_print:float = -1):
	$Next_word_timer.stop()
	hide_text()
	single_word = true
	cur_text = text
	if custom_time_to_print != -1:
		$Next_letter_timer.wait_time = custom_time_to_print/len(cur_text)
	$Next_letter_timer.start()
	

func start_printing(custom_time_to_print:float = -1):
	single_word = false
	$Next_word_timer.stop()
	hide_text()
	cur_text = dialogue[cur_text_index]
	if custom_time_to_print != -1:
		$Next_letter_timer.wait_time = custom_time_to_print/len(cur_text)
	$Next_letter_timer.start()
	
func finished_word():
	$Next_letter_timer.stop()
	
	if(single_word):
		single_word=false
		if(hide_afterwards):
			await get_tree().create_timer(wait_before_hide).timeout
			hide_text()
		return
	
	#Finished dialogue
	if(cur_text_index == len(dialogue)-1):
		if loop_dialogue:
			cur_text_index=-1
			$Next_word_timer.start()
			return
		
		if(hide_afterwards):
			await get_tree().create_timer(wait_before_hide).timeout
			hide_text()
			return
	
	$Next_word_timer.start()
	
func show_whole_text():
	finished_word()
	shown_text = dialogue[cur_text_index]
	
func hide_text():
	$Next_letter_timer.stop()
	shown_text = ""
	cur_text_index = 0
	
	
func _on_next_letter_timer_timeout() -> void:
	var len_text = len(cur_text)
	for i in range(len(cur_text)+1):
		if i >= len(shown_text) and i<len(cur_text):
			shown_text+=cur_text[i]
			return
	
	finished_word()
	return

func _on_next_word_timer_timeout() -> void:
	$Next_word_timer.stop()
	
	if(cur_text_index < len(dialogue)-1):
		shown_text = ""
		cur_text_index +=1
		cur_text = dialogue[cur_text_index]
		start_printing()
