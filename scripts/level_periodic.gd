extends Node2D

var state: int = 0

var quote_index := 0
var quotes = [
	"You think theese ARe GONna work?", 
	"Wrong! Are you eleMENTAL?!", 
	"Still no reaction", 
	"Knock Knock, Who's There? Beryl. Beryl who? Beryl and Lium", 
	"Guys, stop it with the puns. We've all sulfured enough.", 
	"HeHeHe, no.",
	"Can you show me chemical formula for nitrogen monoxide?",
	"NO",
	"Okay, then what about sodium hydrade?",
	"Nah",
	"Not even sodium hypobromite?",
	"NaBrO",
	]

func _ready() -> void:
	await SceneManager.transition_done
	$Text_displayer.write("Do you feel the chemistry?")


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
		SceneManager.next_level("", SceneManager.ANIMATIONS.HOCKEY)


func _on_table_wrong_pressed() -> void:
	$Text_displayer.write(quotes[quote_index])
	quote_index = (quote_index + 1) % quotes.size()
	state = 0
