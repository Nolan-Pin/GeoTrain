extends CanvasLayer

const nb_of_guess = 4
var solution: CountryAttributes
var countries: AvailableCountry
var round: int
var found: int
var not_found: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countries = load("res://data/available_country.tres")
	start_round(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_round(country_index: int) -> void:
	solution = countries.available[country_index]
	round = 0
	found = 0
	not_found = 0
	update_score()
	
	$Country.set_texture(solution.image)
	
	var choices: Array[String] = [solution.en_name]
	for i in range(nb_of_guess-1):
		var random_country = countries.available[randi() % countries.available.size()]
		choices.append(random_country.en_name)
	
	choices.shuffle()
	$Choice1.text = choices[0].capitalize()
	$Choice2.text = choices[1].capitalize()
	$Choice3.text = choices[2].capitalize()
	$Choice4.text = choices[3].capitalize()


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
