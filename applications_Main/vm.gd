extends Node2D

@onready var window = $Window

@onready var hostname_enter = $Window/Control/VBoxContainer/HBoxContainer/Hostname_enter
@onready var back_button = $Window/Control/VBoxContainer/HBoxContainer/Back_button
@onready var forward_button = $Window/Control/VBoxContainer/HBoxContainer/Forward_button
@onready var history = $Window/Control/VBoxContainer/HBoxContainer/History


var othersOpen = 0

signal vmTop()

@onready var hostDict = {}


var isOpen = false
var test = 1
var itemListNumber = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	othersOpen = 0
	isOpen = false
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close():
	visible = false
	isOpen = false

func _on_computer_vm_open():
	othersOpen = 0
	visible = true
	isOpen = true


func _on_hostname_enter_text_submitted(new_text):
	history.add_item(new_text, itemListNumber)
	itemListNumber += 1


func _on_vm_window_closed():
	close()


func _on_window_top():
	vmTop.emit()
