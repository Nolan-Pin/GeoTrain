extends Node

var game_scene: PackedScene
var game_instance: CountryShape
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_scene = load("res://guess_the_shape/country_shape.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game() -> void:
	game_instance = game_scene.instantiate()
	game_instance.game_over.connect(game_ended)
	add_child(game_instance)
	$HUD.hide()

func game_ended(score: int) -> void:
	game_instance.queue_free()
	$HUD.show()
