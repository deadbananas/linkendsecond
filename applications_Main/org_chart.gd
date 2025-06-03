extends Node2D


@onready var window = $Window


signal orgTop()

var isOpen = false
var test = 1
var othersOpen = 0
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


func _on_computer_org_chart_opened():
	othersOpen = 0
	visible = true
	isOpen = true


#func _on_computer_map_open():
	#if othersOpen < 1:
		#othersOpen += 1
	#else:
		#isOpen = false
		#visible = false


#func _on_computer_vm_open():
	#if othersOpen < 1:
		#othersOpen += 1
	#else:
		#isOpen = false
		#visible = false


func _on_window_closed():
	close()


func _on_window_top():
	orgTop.emit()
