extends ColorRect

var clicked_pos
var rects_positions = []
var corn_clicked = false

func _ready():
	set_rectangles_positions()
	create_rectangles()


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked_pos = event.position
		else:
			clicked_pos = false
	if event is InputEventMouseMotion:
		if clicked_pos is Vector2:
			move()


func move():
	position = get_global_mouse_position() - clicked_pos

func resize(corner): #triggered from children (squaret.gd)
	var to_size = size
	var to_pos = position
	match corner:
		0: #topleft
			to_pos = get_global_mouse_position() 
			to_size = size - get_local_mouse_position()
		1: #topright
			to_pos.y = get_global_mouse_position().y
			to_size.y = size.y - get_local_mouse_position().y
			to_size.x = get_local_mouse_position().x
		2: #botleft
			to_pos.x = get_global_mouse_position().x
			to_size.x = size.x - get_local_mouse_position().x
			to_size.y = get_local_mouse_position().y
		3: #botright
			to_size = get_local_mouse_position()
	size = to_size
	position = to_pos
	set_rectangles_positions()
	update_rects_positions()

func set_rectangles_positions():
		rects_positions = [
		Vector2(-4, -4), #topleft
		Vector2(size.x-6, -4), #topright
		Vector2(-4, size.y-6), #botleft
		size - Vector2(6, 6) #botright
	]

func create_rectangles():
	for i in 4:
		var newrect = ColorRect.new()
		newrect.size = Vector2(10, 10)
		newrect.color = Color(0,0,0)
		newrect.position = rects_positions[i]
		newrect.name = "squaret" + str(i)
		newrect.set_script(load("res://squaret.gd")) #attach the other script
		#newrect.ind = i
		add_child(newrect, true)

func update_rects_positions():
	for item in get_children():
		if item is ColorRect:
			item.rect_position = rects_positions[item]
