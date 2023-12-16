extends Node


func _ready():
	Haptics.init()


func _on_LightBtn_pressed():
	Haptics.light()


func _on_MediumBtn_pressed():
	Haptics.medium()


func _on_HeavyBtn_pressed():
	Haptics.heavy()
