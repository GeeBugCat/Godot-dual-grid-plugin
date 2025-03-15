@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_custom_type("DualGridTileMapLayer", "TileMapLayer", preload("res://addons/dualgridtilemaplayer/dualgridtilemaplayerscript.gd"), preload("res://addons/dualgridtilemaplayer/DualGridIcon.png"))
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("DualGridTileMapLayer")
	pass
