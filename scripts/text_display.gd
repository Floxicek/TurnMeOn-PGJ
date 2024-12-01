extends Node2D

var rng = RandomNumberGenerator.new()

@export var dialogue = []
@export var time_between_letters = 0.2
#@export var time_between_dialogues = 1
@export var wait_before_hide: float = 3
#@export var hide_afterwards:bool = false
#@export var loop_dialogue:bool = false
@export var font_size := 361


@onready var label = $Label
var target_text: String = ""
var _target_text_index: int = 0

signal finished
var is_done = true
@onready var next_letter_timer = $NextLetterTimer
@onready var next_word_timer = $NextWordTimer
@onready var hide_text_timer = $HideTextTimer


var _wrong_button_dialogue: Array[String] = [
	"Nope, not this one.",
	"Nope, nope, nopity, nope.",
	"No.",
	"This button isn’t giving.",
	"Not slay. ",
	"Nuh uh.",
	"Nice try but no.",
	"That’s the wrong button.",
	"That’s the wrong button again.",
	"Not this one! Look again!",
	#"This be not the proper button, oh thou mighty knight.",
	#"This be not the path to progress, thou mighty knight.",
	#"Attempt a different path, oh thou sorcerer of the machine.",
]
func _ready() -> void:
	$NextLetterTimer.wait_time = time_between_letters
	#$NextWordTimer.wait_time = time_between_dialogues
	$HideTextTimer.wait_time = wait_before_hide
	label.add_theme_font_size_override("font_size", font_size)
	_reset_label()
	 #"theme_override_font_sizes/font_size"

func _reset_label(new_string = false):
	label.text = ""
	_target_text_index = 0
	hide_text_timer.stop()
	next_letter_timer.stop()
	if new_string:
		next_letter_timer.start()
		hide_text_timer.start()

func write_dialogue(_dialogue: Array):
	dialogue = _dialogue
	if dialogue.size() > 0:
		_dialogue_next()

func write(text: String):
	target_text = text
	$NextLetterTimer.start()
	$HideTextTimer.stop()
	is_done = false

func _dialogue_next():
	write(dialogue[0])
	dialogue.pop_front()

func write_wrong_button():
	write(_wrong_button_dialogue[rng.randi_range(0, len(_wrong_button_dialogue) - 1)])

func _next_letter():
	#print("Next letter call")
	if _target_text_index == 0:
		hide_text_timer.stop()
		hide_text_timer.start()
	
	elif (_target_text_index) >= len(target_text):
		if label.text == target_text:
			return
		else:
			_reset_label(true)
	var cur_text = label.text
	var new_text = label.text + target_text[_target_text_index]
	
	if not target_text.begins_with(new_text):
		_reset_label(true)
	else:
		# The text continues... continue writing
		label.text = new_text
		_target_text_index += 1


func _on_hide_text_timer_timeout() -> void:
#	Check if we have more dialogs
	#print("Hide text timer call")
	_reset_label()
	if dialogue.size() > 0:
		_dialogue_next()
	else:
		finished.emit()
		is_done = true
