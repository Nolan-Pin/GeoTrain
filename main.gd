extends Node

@export var country: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(create_country("fr", Vector2(400, 300)))
	add_child(create_country("se", Vector2(500, 300)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func child_clicked(named: String):
	print(named)
	pass

func create_country(name: String, pos: Vector2) -> Node2D:
	const dic = {"fr": "res://img/fr.png", "se": "res://img/se.png"}
	var obj = country.instantiate()
	print(dic[name])
	obj.get_node("Sprite2D").texture = load(dic[name])
	obj.set_name(name)
	obj.position = pos
	obj.connect("clicked", child_clicked)
	
	return obj
	
