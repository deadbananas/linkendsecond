extends Node2D

@onready var window = $Window


var isOpen = false
var test = 1
var othersOpen = 0

signal mapTop()
signal toggle()

func _ready():
	othersOpen = 0
	isOpen = false
	visible = false

func _on_computer_map_open():
	othersOpen = 0
	visible = true
	isOpen = true
	toggle.emit()
	#window.visible = true
	
func close():
	isOpen = false
	visible = false
	toggle.emit()
	#receive signal from window here

#func _on_computer_org_chart_opened():
	#if othersOpen < 1:
		#othersOpen += 1
	#else:
		#isOpen = false
		#visible = false
		##window.visible = false
#
#
#func _on_computer_vm_open():
	#if othersOpen < 1:
		#othersOpen += 1
	#else:
		#isOpen = false
		#visible = false
		##window.visible = false


func _on_window_closed():
	close()


func _on_window_top():
	mapTop.emit()
