# Kale Tools

Collection of Godot 4.x plugins I made and use daily when working with Battlefield 6 SDK in Godot.
Pick the full suite called **Kale_Tools** or just the individual tool you need. 
You only need **Kale_Tools** if you want all of them.

<img width="2551" height="1400" alt="Kale Tools" src="https://github.com/user-attachments/assets/95fd1823-04ca-48be-9518-03d8eb79dbdc" />

## What's in the box

| Folder | What it does |
|--------|-------------|
| [`Kale_Tools/`](Kale_Tools/) | All tools in one tabbed dock — just enable and go |
| [`Kale_Chroma/`](Kale_Chroma/) | Material colors, textures, and patterns with auto-restore |
| [`Kale_Luma/`](Kale_Luma/) | Sky, sun with shadows, ambient light, fog, and GI |
| [`Kale_MapDecal/`](Kale_MapDecal/) | Map texture decal projection with level presets |
| [`Kale_CopyTransforms/`](Kale_CopyTransforms/) | Copy position, rotation, scale between two nodes |
| [`Kale_Import/`](Kale_Import/) | Prefab import with search, wildcards, and sort by version or date |

> Don't enable Kale_Tools and the individual tools at the same time — the same tools would show up twice.

## Installation

1. Pick your folder(s) from the list above
2. Copy them into your project's `addons/` directory
3. Enable in **Godot > Project > Project Settings > Plugins**

## Tools

- **Chroma** — Apply material color, texture, and pattern. Restores materials on Godot reboot.
  <img width="603" height="859" alt="Chroma" src="https://github.com/user-attachments/assets/c988cc12-2f14-4ac7-80fc-e0f5cde80d5b" />

- **Luma** — Sky, sun with shadows, ambient light, fog, and GI. Supports custom HDRIs.
  <img width="603" height="837" alt="Luma" src="https://github.com/user-attachments/assets/3713d46e-fc73-4ef8-ab13-c4176a0821a6" />

- **MapDecal** — Project map texture decals onto static geometry. Level presets included.
  <img width="605" height="865" alt="Map Project" src="https://github.com/user-attachments/assets/c6cd4468-6598-4457-95e9-cdd061e6b10f" />

- **Copy Transforms** — Copy position, rotation, and scale from one node to another.
  <img width="603" height="224" alt="Copy Transforms" src="https://github.com/user-attachments/assets/ba73f538-7c39-49d2-b767-65f9159fd523" />

- **Import** — Import prefabs with wildcard search and version or date sorting.
  <img width="593" height="342" alt="Import" src="https://github.com/user-attachments/assets/d8f15e22-3f53-4dda-b14c-c3bfcc4f3da7" />

- **Export** — Chain tools together and run them in order. Kale_Tools only.
  <img width="602" height="324" alt="Export" src="https://github.com/user-attachments/assets/5e2054cd-c0ae-4cdd-9494-7e3a0fd6d093" />

## Requirements

- Godot 4.x
- Portal SDK 1.3.3 or later (for MapDecal tool)

## Credits

Textures from [Polyhaven](https://polyhaven.com/textures) (CC0).  
HDRI from [Polyhaven](https://polyhaven.com/hdris) (CC0).

## License

MIT. See [LICENSE](LICENSE).
