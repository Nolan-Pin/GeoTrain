extends CanvasLayer

const nb_of_guess = 4
var countries: AvailableCountry
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countries = load("res://data/available_country.tres")
	start_round(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_round(country_index: int) -> void:
	$Country.set_texture(countries.available[country_index].image)
	var choices: Array[String] = [countries.available[country_index].en_name]
	
	for i in range(nb_of_guess-1):
		var random_country = countries.available[randi() % countries.available.size()]
		choices.append(random_country.en_name)
	
	choices.shuffle()
	$Choice1.text = choices[0].capitalize()
	$Choice2.text = choices[1].capitalize()
	$Choice3.text = choices[2].capitalize()
	$Choice4.text = choices[3].capitalize()
