@tool
extends EditorPlugin

var _dock: Control
var _tool: Node


func _enter_tree():
	var root: String = get_script().resource_path.get_base_dir()

	_tool = preload("tool_chroma.gd").new()
	_tool.plugin_root = root

	var panel: Control = _tool.build_panel()
	panel.name = "Kale Chroma"
	panel.add_child(_tool)

	_dock = panel
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, _dock)
	scene_changed.connect(_on_scene_changed)
	_on_scene_changed(EditorInterface.get_edited_scene_root())


func _exit_tree():
	if scene_changed.is_connected(_on_scene_changed):
		scene_changed.disconnect(_on_scene_changed)
	if is_instance_valid(_dock):
		remove_control_from_docks(_dock)
		_dock.queue_free()


func _on_scene_changed(root: Node) -> void:
	if _tool and _tool.has_method("on_editor_scene_changed"):
		_tool.on_editor_scene_changed(root)
