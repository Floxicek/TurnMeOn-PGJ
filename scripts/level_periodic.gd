extends Node2D

var state: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await SceneManager.transition_done
	$Text_displayer.start_printing_single_word("Do you feel the chemistry?", 1.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func evaluate_element_click(desired_state: int, element: String) -> bool:
	if state == desired_state:
		$PeriodicTable.get_node(element).flash(Color(0, 0.45, 0))
		state += 1
		return true
	else:
		$PeriodicTable.get_node(element).flash(Color.RED)
		state = 0
		return false


func _on_p_element_pressed() -> void:
	evaluate_element_click(0, "P_element")


func _on_l_element_pressed() -> void:
	evaluate_element_click(1, "L_element")


func _on_a_element_pressed() -> void:
	evaluate_element_click(2, "A_element")


func _on_y_element_pressed() -> void:
	if evaluate_element_click(3, "Y_element"):
		SceneManager.next_level()


func _on_table_wrong_pressed() -> void:
	$Text_displayer.start_printing_single_word("Wrong! Are you eleMENTAL?!")
	state = 0
