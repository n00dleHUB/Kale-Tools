@tool
extends Node

static var plugin_root := ""

const PRESETS := {
	"Neutral": { "intensity": 1.0, "rotation": 90.0, "ambient": Color.WHITE, "ambient_strength": 0.6,
		"sun": true, "sun_elevation": 45.0, "sun_azimuth": 150.0, "sun_color": Color(1, 0.96, 0.90), "sun_energy": 1.0,
		"hdri": "kloofendal_48d_partly_cloudy_puresky_4k.hdr",
		"sdfgi": false, "ssao": false, "ssil": false, "ssr": false },
	"Moody": { "intensity": 0.5, "rotation": 90.0, "ambient": Color(0.3, 0.3, 0.35), "ambient_strength": 0.3,
		"sun": true, "sun_elevation": 20.0, "sun_azimuth": 150.0, "sun_color": Color(0.8, 0.6, 0.4), "sun_energy": 0.4,
		"fog": true, "fog_density": 0.008, "fog_color": Color(0.3, 0.3, 0.35),
		"hdri": "kloofendal_48d_partly_cloudy_puresky_4k.hdr",
		"sdfgi": false, "ssao": false, "ssil": false, "ssr": false },
	"Warm": { "intensity": 1.2, "rotation": 90.0, "ambient": Color(1.0, 0.88, 0.65), "ambient_strength": 0.7,
		"sun": true, "sun_elevation": 30.0, "sun_azimuth": 150.0, "sun_color": Color(1.0, 0.7, 0.45), "sun_energy": 0.8,
		"hdri": "kloofendal_48d_partly_cloudy_puresky_4k.hdr",
		"sdfgi": false, "ssao": false, "ssil": false, "ssr": false },
	"Cool": { "intensity": 0.8, "rotation": 90.0, "ambient": Color(0.65, 0.75, 1.0), "ambient_strength": 0.5,
		"sun": true, "sun_elevation": 50.0, "sun_azimuth": 150.0, "sun_color": Color(0.7, 0.8, 1.0), "sun_energy": 0.7,
		"hdri": "kloofendal_48d_partly_cloudy_puresky_4k.hdr",
		"sdfgi": false, "ssao": false, "ssil": false, "ssr": false },
	"Sunrise": { "intensity": 1.0, "rotation": 90.0, "ambient": Color(0.9, 0.7, 0.5), "ambient_strength": 0.5,
		"sun": true, "sun_elevation": 10.0, "sun_azimuth": 90.0, "sun_color": Color(1.0, 0.75, 0.45), "sun_energy": 0.4,
		"hdri": "kloofendal_48d_partly_cloudy_puresky_4k.hdr",
		"sdfgi": false, "ssao": false, "ssil": false, "ssr": false },
	"Sunset": { "intensity": 0.8, "rotation": 90.0, "ambient": Color(0.8, 0.5, 0.35), "ambient_strength": 0.4,
		"sun": true, "sun_elevation": 10.0, "sun_azimuth": 260.0, "sun_color": Color(1.0, 0.55, 0.3), "sun_energy": 0.25,
		"hdri": "kloofendal_48d_partly_cloudy_puresky_4k.hdr",
		"sdfgi": false, "ssao": false, "ssil": false, "ssr": false },
	"Night": { "intensity": 0.8, "rotation": 90.0, "ambient": Color(0.65, 0.75, 1.0), "ambient_strength": 0.5,
		"sun": true, "sun_elevation": 45.0, "sun_azimuth": 150.0, "sun_color": Color.WHITE, "sun_energy": 0.3,
		"sky": true, "hdri": "qwantani_moon_noon_puresky_2k.hdr",
		"sdfgi_energy": 0.75,
		"sdfgi": false, "ssao": false, "ssil": false, "ssr": false },
}

static func get_preset_names() -> PackedStringArray:
	var names: PackedStringArray = []
	for key in PRESETS.keys():
		names.append(key)
	return names


static func get_hdri_files() -> PackedStringArray:
	var names: PackedStringArray = []
	var dir := DirAccess.open(plugin_root + "/textures/")
	if dir:
		for f in dir.get_files():
			if f.get_extension().to_lower() == "hdr":
				names.append(f)
		names.sort()
	return names


static func apply_environment(
	hdri_filename: String,
	intensity: float,
	rotation: float,
	ambient_color: Color,
	ambient_strength: float,
) -> void:
	var root := EditorInterface.get_edited_scene_root()
	if not root:
		return

	var we := root.get_node_or_null("WorldEnvironment") as WorldEnvironment
	if not we:
		we = WorldEnvironment.new()
		we.name = "WorldEnvironment"
		root.add_child(we, true)
		we.set_owner(root)

	var env := we.environment
	if not env:
		env = Environment.new()
		env.resource_local_to_scene = true
		we.environment = env

	var mat := PanoramaSkyMaterial.new()
	if not hdri_filename.is_empty():
		var path := hdri_filename
		if not path.contains("/"):
			path = plugin_root + "/textures/" + hdri_filename
		if ResourceLoader.exists(path):
			var tex := load(path) as Texture2D
			if tex:
				mat.panorama = tex

	mat.energy_multiplier = clamp(intensity, 0.0, 4.0)

	var sky := Sky.new()
	sky.sky_material = mat
	env.sky = sky
	env.background_mode = Environment.BG_SKY
	env.sky_rotation = Vector3(0, deg_to_rad(rotation), 0)

	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = ambient_color
	env.ambient_light_energy = clamp(ambient_strength, 0.0, 4.0)


static func update_sun(enabled: bool, elevation: float, azimuth: float, color: Color, energy: float, shadows: bool, shadow_distance: float, shadow_bias: float) -> void:
	var root := EditorInterface.get_edited_scene_root()
	if not root:
		return

	var sun := root.get_node_or_null("Sun") as DirectionalLight3D
	if not enabled:
		if sun:
			sun.queue_free()
		return

	if not sun:
		sun = DirectionalLight3D.new()
		sun.name = "Sun"
		root.add_child(sun, true)
		sun.set_owner(root)

	sun.rotation_degrees = Vector3(-elevation, azimuth, 0)
	sun.light_color = color
	sun.light_energy = energy
	sun.shadow_enabled = shadows
	if shadows:
		sun.directional_shadow_max_distance = shadow_distance
		sun.shadow_bias = shadow_bias


static func clear_sun() -> void:
	var root := EditorInterface.get_edited_scene_root()
	if not root:
		return
	var sun := root.get_node_or_null("Sun") as DirectionalLight3D
	if sun:
		sun.queue_free()


static func update_gi_ao(env: Environment, sdfgi: bool, ssao: bool, ssil: bool, ssr: bool, sdfgi_energy: float) -> void:
	if not env:
		return
	env.sdfgi_enabled = sdfgi
	env.ssao_enabled = ssao
	env.ssil_enabled = ssil
	env.ssr_enabled = ssr
	env.sdfgi_energy = sdfgi_energy


static func disable_editor_preview_sun() -> void:
	var editor := EditorInterface.get_base_control()
	if not editor:
		return
	var sun_icon := editor.get_theme_icon("DirectionalLight", "EditorIcons")
	var buttons := editor.find_children("*", "BaseButton", true, false)
	for btn in buttons:
		var b := btn as BaseButton
		if not b:
			continue
		var tt := b.tooltip_text.strip_edges().to_lower()
		if "sun" in tt and "toggle" in tt:
			if b.icon == sun_icon:
				b.pressed.emit()
			return


static func clear_environment() -> void:
	var root := EditorInterface.get_edited_scene_root()
	if not root:
		return
	var we := root.get_node_or_null("WorldEnvironment") as WorldEnvironment
	if we:
		we.queue_free()
