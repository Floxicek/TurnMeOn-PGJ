extends Node2D

@export var arrive_distance = 300
@export var arrive_duration = 4
@export var wait_before_pull = 1
@export var pull_distance = 50
@export var pull_duration = 0.5
var arrive_tween: Tween
var pull_tween: Tween

signal pulled_signal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	arrive_tween = get_tree().create_tween()
	arrive_tween.tween_property(self, "position", Vector2(position + Vector2.DOWN * arrive_distance), 3)
	arrive_tween.set_trans(Tween.TRANS_CUBIC)
	arrive_tween.tween_callback(pull_string)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func pull_string():
	await get_tree().create_timer(wait_before_pull).timeout
	pull_string_down()
	

func pull_string_down():
	pull_tween = get_tree().create_tween()
	pull_tween.tween_property(self, "position", Vector2(position + Vector2.DOWN * pull_distance), pull_duration/2)
	pull_tween.set_trans(Tween.TRANS_CUBIC)
	pull_tween.tween_callback(pull_string_up)

func pull_string_up():
	pull_tween = get_tree().create_tween()
	pull_tween.tween_property(self, "position", Vector2(position + Vector2.UP * pull_distance), pull_duration/2)
	pull_tween.set_trans(Tween.TRANS_CUBIC)
	pull_tween.tween_callback(func(): pulled_signal.emit())
