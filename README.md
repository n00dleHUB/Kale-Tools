# Kale Tools

Collection of Godot 4.x scene editing utilities. Pick the full suite or just the tools you need.

## Installation

1. Browse the folders below — each one is a self-contained Godot plugin.
2. Copy the folder(s) you want into your project's `addons/` directory.
3. Enable the plugin(s) in **Godot > Project > Project Settings > Plugins**.

| Install | Contains |
|---------|----------|
| [`Kale_Tools/`](Kale_Tools/) | All 6 tools in one tabbed dock |
| [`Kale_Chroma/`](Kale_Chroma/) | Material color, texture, and pattern tool |
| [`Kale_Luma/`](Kale_Luma/) | Lighting — sky, sun, ambient, fog, GI |
| [`Kale_MapDecal/`](Kale_MapDecal/) | Map texture decal projection with presets |
| [`Kale_CopyTransforms/`](Kale_CopyTransforms/) | Copy position, rotation, scale between nodes |
| [`Kale_Import/`](Kale_Import/) | Prefab import with wildcard search and sorting |

> **Tip:** Don't enable `Kale_Tools/` alongside the individual plugins — the tools would appear in two docks.

## Tools

**Chroma** — Apply material color, texture, and pattern. Restores materials on Godot reboot.

**Luma** — Lighting tool. Adds and controls sky, sun, ambient light, fog, and global illumination. Supports custom cubemap/HDRIs. Sun casts crisp shadows with adjustable distance and bias.

**MapDecal** — Map texture decals with presets for each map. Projects onto static geometry. Decals only project onto the "Static" geometry in the scene.

**Copy Transforms** — Copy position, rotation, and scale from a source node to a target node. Select nodes from the viewport or scene tree.

**Import** — Imports prefabs from a folder with wildcard search and sort (by version or date). Includes a folder browser.

**Export** — Order and chain tools together for automated export. (Available in the full `Kale_Tools/` suite only.)

## Requirements

- Godot 4.x
- Portal SDK 1.3.3 or later (for MapDecal tool)

## Credits

Textures from [Polyhaven](https://polyhaven.com/textures) (CC0).  
HDRI from [Polyhaven](https://polyhaven.com/hdris) (CC0).

## License

MIT. See [LICENSE](LICENSE).
