extends ColorRect

var ind: int
var clicked = false

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked = true
		else:
			clicked = false
	if event is InputEventMouseMotion:
		if clicked:
			get_parent().resize(ind) #trigger resize function in parent
