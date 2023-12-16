extends Node

signal on_error(error_message)

var haptics = null


# Change this to _ready() if you want automatically init
func init():
	if Engine.has_singleton("Haptics"):
		haptics = Engine.get_singleton("Haptics")


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
