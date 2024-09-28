extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_country_list():
	var file = FileAccess.open("res://data/country_attributes.tres", FileAccess.READ)
	var content = file.get_as_text()
	return content
