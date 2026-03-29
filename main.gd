extends Control

const save_path = "user://userdata.save"

var blood = 0
var amount_per_click = 1

signal blood_changed
signal blood_clicked

func _ready() -> void:
	load_data()
	emit_signal("blood_changed", blood)

func save_data():
	var data = {
		"blood": blood,
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)
	file.close()

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file == null:
			save_data()
			return
		var data = file.get_var()
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			blood = data.get("blood", 0)
	else:
		save_data()

func _on_click_button_button_down() -> void:
	blood += amount_per_click
	print("Blood is now: ", blood)
	emit_signal("blood_changed", blood)
	emit_signal("blood_clicked", amount_per_click)
	save_data()
