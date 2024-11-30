extends Node2D

var shown_text = ""
@export var dialogue: Array[String] = ["Sample text"]
@export var time_between_letters = 0.2
@export var time_between_dialogues = 1
@export var wait_before_hide:float = 3
@export var hide_afterwards:bool = false
@export var loop_dialogue:bool = false


var text_complete:bool = false

var cur_text_index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Next_letter_timer.wait_time = time_between_letters
	$Next_word_timer.wait_time = time_between_dialogues
	shown_text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = shown_text


func start_printing(custom_time_to_print:float = -1):
	if custom_time_to_print != -1:
		$Next_letter_timer.wait_time = custom_time_to_print/len(dialogue[cur_text_index])
	$Next_letter_timer.start()
	
func finished_word():
	$Next_letter_timer.stop()
	
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
	var len_text = len(dialogue[cur_text_index])
	for i in range(len(dialogue[cur_text_index])+1):
		if i >= len(shown_text) and i<len(dialogue[cur_text_index]):
			shown_text+=dialogue[cur_text_index][i]
			return
	
	finished_word()
	return

func _on_next_word_timer_timeout() -> void:
	$Next_word_timer.stop()
	
	if(cur_text_index < len(dialogue)-1):
		shown_text = ""
		cur_text_index +=1
		start_printing()
