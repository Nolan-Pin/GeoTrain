extends Area2D

signal clicked(name: String)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_action_pressed("select") and is_opaque(event.position)):
		clicked.emit(name)


func is_opaque(global_pos: Vector2) -> bool:
	var image: Image = $Sprite2D.get_texture().get_image()
	var image_size = Vector2($Sprite2D.get_texture().get_size() * $Sprite2D.scale)
	var pixel_coord = (image_size / 2 + to_local(global_pos)) * 2
	
	return image.get_pixelv(pixel_coord)[3] == 1
