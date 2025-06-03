extends CharacterBody2D

var draggingDistance
var dir
var dragging
var newPosition = Vector2()

var mouse_in = false

signal closed()
signal top()
func _ready():
	pass
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			self.get_viewport().set_input_as_handled()
		else:
			dragging = false
			
	elif event is InputEventMouseMotion:
		if dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir

func _physics_process(delta):
	if dragging:
		velocity = (newPosition - position) * Vector2(30, 30)
		move_and_collide(velocity * delta)
	
 # Set these two functions through the Area2D Signals!!
func mouse_entered():
	mouse_in = true

func mouse_exited():
	mouse_in = false

# Optional, I have a close button to get rid of the UI element
func _on_close_pressed():
	closed.emit()

func pass_input(event: InputEvent, shape_idx):
	if event is InputEventMouseButton:
		print("top")
		top.emit()
		if !mouse_in:
			self.get_viewport().set_input_as_handled()

func _on_clicked_in_input_event(viewport, event, shape_idx):
	print(viewport)
	print(shape_idx)
	if event is InputEventMouseButton:
		print("top")
		top.emit()
		if !mouse_in:
			self.get_viewport().set_input_as_handled()
