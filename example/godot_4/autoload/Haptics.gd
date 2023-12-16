extends Node

signal on_error(error_message)

var haptics = null


# Change this to _ready() if you want automatically init
func init():
	if Engine.has_singleton("Haptics"):
		haptics = Engine.get_singleton("Haptics")
		init_signals()


func init_signals():
	haptics.connect("error", self, "_on_error")


func _on_error(error_message):
	emit_signal("on_error", error_message)


func light():
	if not haptics:
		not_found_plugin()
		return
	
	haptics.light()


func medium():
	if not haptics:
		not_found_plugin()
		return
	
	haptics.medium()


func heavy():
	if not haptics:
		not_found_plugin()
		return
	
	haptics.heavy()


func not_found_plugin():
	print('[Haptics] Not found plugin. Please ensure that you checked Haptics plugin in the export template')
