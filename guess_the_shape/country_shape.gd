extends Node

class_name CountryShape

signal round_over(win: bool)
signal game_over(point: int, total: int)

const DEFAULT_ROUND: int = 20
const nb_of_choices: int = 4

var solution: CountryAttributes
var countries: AvailableCountry
var round: int
var found: int
var not_found: int
var nb_of_guess: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countries = load("res://data/available_country.tres")
	round_over.connect(end_round)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_game(nb_round: int) -> void:
	round = 0
	found = 0
	not_found = 0
	nb_of_guess = nb_round if nb_round != 0 else DEFAULT_ROUND
	update_score()
	start_round()


func start_round() -> void:
	var choices: Array[CountryAttributes] = countries.available
	choices.shuffle()
	solution = choices[0]
	$Choice1.text = choices[0].en_name.capitalize()
	$Choice2.text = choices[1].en_name.capitalize()
	$Choice3.text = choices[2].en_name.capitalize()
	$Choice4.text = choices[3].en_name.capitalize()
	$Country.set_texture(load(solution.path))


func end_round(success: bool) -> void:
	round += 1
	found += int(success)
	not_found += int(not success)
	update_score()
	
	if (round >= nb_of_guess):
		game_over.emit(found, nb_of_guess)
	else:
		start_round()


func choice_made(selected: int) -> void:
	var button: Button = find_child("Choice" + str(selected))
	round_over.emit(button.text.to_lower() == solution.en_name)

func update_score() -> void:
	$Scoring/Progress.text = str(round) + "/" + str(nb_of_guess)
	$Scoring/Found.text = str(found)
	$Scoring/NotFound.text = str(not_found)
