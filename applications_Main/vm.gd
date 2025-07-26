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
	print_lines_table(load_lines_from_json("res://assets/data/hostnames"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func load_lines_from_json(path: String) -> Array:
	var lines_data: Array = []
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var json_string = file.get_as_text()
		file.close()

		var parsed_result = JSON.parse_string(json_string)
		if parsed_result is Dictionary:
			if parsed_result.has("sheets") and parsed_result["sheets"].size() > 0:
				var first_sheet = parsed_result["sheets"][0]
				if first_sheet.has("lines"):
					lines_data = first_sheet["lines"]
				else:
					print("Error: 'lines' not found in first sheet.")
			else:
				print("Error: 'sheets' missing or empty.")
		else:
			print("Error: JSON content is not a Dictionary.")
	else:
		print("Error: File not found at path: ", path)
	return lines_data


func print_lines_table(lines_data: Array):
	if lines_data.size() == 0:
		print("No data to display.")
		return

	var columns := ["Hostname", "name", "floor", "roomname", "job title"]
	var col_widths := {}

	# Set initial widths based on header labels
	for col in columns:
		col_widths[col] = col.length()

	# Measure actual content widths
	for line in lines_data:
		for col in columns:
			var value := str(line.get(col, ""))
			col_widths[col] = max(col_widths[col], value.length())

	# Print header
	var header := ""
	for col in columns:
		header += pad_right(col, col_widths[col] + 2)
	print(header)
	print("-".repeat(header.length()))

	# Print each row
	for line in lines_data:
		var row := ""
		for col in columns:
			var value := str(line.get(col, ""))
			row += pad_right(value, col_widths[col] + 2)
		print(row)

		
func pad_right(text: String, width: int) -> String:
	return text + " ".repeat(max(width - text.length(), 0))


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

func _on_window_top():
	vmTop.emit()


func _on_window_closed():
	close()
	
	
