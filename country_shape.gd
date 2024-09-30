extends CanvasLayer

const nb_of_guess = 4
const nb_of_choices: int = 4

var solution: CountryAttributes
var countries: AvailableCountry
var round: int
var found: int
var not_found: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countries = load("res://data/available_country.tres")
	start_round(randi() % countries.available.size())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_round(country_index: int) -> void:
	round = 0
	found = 0
	not_found = 0
	update_score()
	
	var choices: Array[CountryAttributes] = pick_n_element(countries.available, nb_of_choices)
	solution = choices[0]
	choices.shuffle()
	$Choice1.text = choices[0].en_name.capitalize()
	$Choice2.text = choices[1].en_name.capitalize()
	$Choice3.text = choices[2].en_name.capitalize()
	$Choice4.text = choices[3].en_name.capitalize()
	$Country.set_texture(solution.image)


func end_round(success: bool) -> void:
	round += 1
	if (success):
		found += 1
	else:
		not_found += 1
	update_score()


func choice_made(selected: int) -> void:
	var button: Button = find_child("Choice" + str(selected))
	end_round(button.text.to_lower() == solution.en_name)

func update_score() -> void:
	$Scoring/Progress.text = str(round) + "/" + str(nb_of_guess)
	$Scoring/Found.text = str(found)
	$Scoring/NotFound.text = str(not_found)

func pick_n_element(array: Array[CountryAttributes], n: int) -> Array[CountryAttributes]:
	var selection: Array[CountryAttributes]
	selection.push_back(array.pick_random())
	for i in range(n-1):
		var random_element = array.pick_random()
		while (random_element in selection):
			random_element = array.pick_random()
		selection.push_back(random_element)

	return selection
