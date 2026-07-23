@tool
extends Node

static var plugin_root := ""


static func build_tab_dock() -> VBoxContainer:
	var dock := VBoxContainer.new()
	dock.custom_minimum_size = Vector2(280, 0)

	var tab_bar := TabBar.new()
	tab_bar.tab_alignment = TabBar.ALIGNMENT_LEFT
	dock.add_child(tab_bar)

	var tools := _create_tools()
	var panels: Array[Control] = []
	for tool in tools:
		tool.plugin_root = plugin_root
		var name := tool.get_tool_name()
		var panel := tool.build_panel() as Control
		panel.name = name
		panel.add_child(tool)
		panel.visible = false
		panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
		dock.add_child(panel)
		panels.append(panel)
		tab_bar.add_tab(name)

	if panels.size() > 0:
		panels[0].visible = true
		tab_bar.current_tab = 0

	tab_bar.tab_changed.connect(func(i: int):
		for p in panels.size():
			panels[p].visible = (p == i)
	)

	return dock


static func _create_tools() -> Array[Node]:
	var result: Array[Node] = []

	var ToolChroma = preload("chroma/tool_chroma.gd")
	result.append(ToolChroma.new())

	var ToolLuma = preload("luma/tool_luma.gd")
	result.append(ToolLuma.new())

	var ToolProject = preload("project/tool_project.gd")
	result.append(ToolProject.new())

	var ToolCopy = preload("copy_transforms/tool_copy.gd")
	result.append(ToolCopy.new())

	var ToolImport = preload("import/tool_import.gd")
	result.append(ToolImport.new())

	var ToolExport = preload("export/tool_export.gd")
	result.append(ToolExport.new())

	return result
