extends CharacterBody2D

var draggingDistance
var dir
var dragging
var newPosition = Vector2()
@onready var ray_cast_2d = $RayCast2D

var mouse_in = false

signal closed()
signal top()
func _ready():
	pass
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_in:
			top.emit()
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
			top.emit()

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
		
func clicked_in():
	top.emit()
	if !mouse_in:
		self.get_viewport().set_input_as_handled()
	


func _on_clicked_in_1_pressed():
	clicked_in()


func _on_clicked_in_2_pressed():
	clicked_in()
