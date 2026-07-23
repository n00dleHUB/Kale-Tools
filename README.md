# Kale Tools

Collection of Godot 4.x scene editing utilities. Pick the full suite called "Kale-Tools" or just the individual tool you need.

<img width="2551" height="1400" alt="Kale Tools" src="https://github.com/user-attachments/assets/95fd1823-04ca-48be-9518-03d8eb79dbdc" />

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

- **Chroma** — Apply material color, texture, and pattern. Restores materials on Godot reboot.
  <img width="603" height="859" alt="Chroma" src="https://github.com/user-attachments/assets/c988cc12-2f14-4ac7-80fc-e0f5cde80d5b" />

- **Luma** — Lighting tool. Adds and controls sky, sun, ambient light, fog, and global illumination. Supports custom cubemap/HDRIs. Sun casts crisp shadows with adjustable distance and bias.
  <img width="603" height="837" alt="Luma" src="https://github.com/user-attachments/assets/3713d46e-fc73-4ef8-ab13-c4176a0821a6" />

- **MapDecal** — Map texture decals with presets for each map. Projects onto static geometry.
  <img width="605" height="865" alt="Map Project" src="https://github.com/user-attachments/assets/c6cd4468-6598-4457-95e9-cdd061e6b10f" />

- **Copy Transforms** — Copy position, rotation, and scale from a source node to a target node. Select nodes from the viewport or scene tree.
  <img width="603" height="224" alt="Copy Transforms" src="https://github.com/user-attachments/assets/ba73f538-7c39-49d2-b767-65f9159fd523" />

- **Import** — Imports prefabs from a folder with wildcard search and sort (by version or date). Includes a folder browser.
  <img width="593" height="342" alt="Import" src="https://github.com/user-attachments/assets/d8f15e22-3f53-4dda-b14c-c3bfcc4f3da7" />

- **Export** — Order and chain tools together for automated export. (Available in the full `Kale_Tools/` suite only.)
  <img width="602" height="324" alt="Export" src="https://github.com/user-attachments/assets/5e2054cd-c0ae-4cdd-9494-7e3a0fd6d093" />

## Requirements

- Godot 4.x
- Portal SDK 1.3.3 or later (for MapDecal tool)

## Credits

Textures from [Polyhaven](https://polyhaven.com/textures) (CC0).  
HDRI from [Polyhaven](https://polyhaven.com/hdris) (CC0).

## License

MIT. See [LICENSE](LICENSE).
