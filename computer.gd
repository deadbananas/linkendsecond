extends Node2D


@onready var time = $UI/time
@onready var bell = $bell
@onready var notif = $bell/notif



@onready var map = $Applications/Map
@onready var vm = $Applications/VM
@onready var org_chart = $Applications/OrgChart



var time_start = 0
var time_now = 0

var begin_clock = "2033-05-12 09:24:32"
var cur_clock = {}
var unix_time = 1999502672
var cur_unix_time = 0


var appDict = {"map": map, "vm": vm, "org": org_chart}
var appArray = []

signal map_open()
signal vm_open()
signal org_chart_opened()

# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = Time.get_unix_time_from_system()
	appDict = {"map": map, "vm": vm, "org": org_chart}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_now = Time.get_unix_time_from_system()
	var time_dif = int(time_now - time_start)
	cur_unix_time = unix_time + time_dif
	cur_clock = Time.get_datetime_string_from_unix_time(cur_unix_time, true)
	time.text = cur_clock
	var j = appArray.size()
	for i in appArray:
		var temp : Node2D = appDict.get(i)
		temp.z_index = j
		j = j - 1
	
func open_Map():
	map_open.emit()
	if appArray.has("map"):
		appArray.erase("map")
	appArray.push_front("map")
	
func open_VM():
	vm_open.emit()
	if appArray.has("vm"):
		appArray.erase("vm")
	appArray.push_front("vm")
	
func open_Org_Chart():
	org_chart_opened.emit()
	if appArray.has("org"):
		appArray.erase("org")
	appArray.push_front("org")
	
func _on_map_pressed():
	open_Map()
	

func _on_vm_pressed():
	open_VM()
	

func _on_org_chart_pressed():
	open_Org_Chart()
	

func _on_map_small_pressed():
	open_Map()


func _on_vm_small_pressed():
	open_VM()


func _on_org_chart_small_pressed():
	open_Org_Chart()


func _on_notes_pressed():
	pass # Replace with function body.


func _on_messages_button_pressed():
	pass # Replace with function body.


func _on_map_map_top():
	if appArray.has("map"):
		appArray.erase("map")
	appArray.push_front("map")

func _on_vm_vm_top():
	if appArray.has("vm"):
		appArray.erase("vm")
	appArray.push_front("vm")


func _on_org_chart_org_top():
	if appArray.has("org"):
		appArray.erase("org")
	appArray.push_front("org")
