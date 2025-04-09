extends Area2D

var is_mouse_in: bool = false

func _on_mouse_entered() -> void:
	is_mouse_in = true

func _on_mouse_exited() -> void:
	is_mouse_in = false

func is_mouse_in_area() -> bool:
	return is_mouse_in
