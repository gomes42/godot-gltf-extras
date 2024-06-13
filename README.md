# 🤖 glTF Extras for Godot Engine (EXPERIMENTAL)

### 🌟 Overview

**glTF Extras for Godot Engine** is an experimental Godot plugin designed to map extra properties (such as Blender custom properties) to Nodes, Lights, and Materials from glTF files. This addon enhances the flexibility and functionality of your Godot projects by leveraging the full potential of the glTF format.

### ✨ Features

- **Nodes**: Support for custom node properties.
- **Lights**: Automatic mapping of light properties such as `omni_range`.
- **Materials**: Automatic application of material properties such as `albedo_color`, `uv1_scale`.

### ⚙️ Configurations

This plugin provides several configuration options:

- `gltf_extras/settings/copy_materials_metadata`: Enable or disable copying metadata for materials.
- `gltf_extras/settings/apply_godot_properties`: Automatically set known Godot properties, like `albedo_color` for materials or `omni_range` for lights.

### 🚧 Current Status

The plugin is still under development. The following features are currently functional:

- Light Properties
- Materials

### 🛠️ Installation

1. **Download the Addon**: Clone or download the repository from [GitHub](https://github.com/lgxm3z/godot-gltf-extras).
    ```bash
    git clone https://github.com/lgxm3z/godot-gltf-extras.git
    ```

2. **Copy to Project**: Copy the `godot-gltf-extras` folder into the `addons` directory of your Godot project.

3. **Enable the Addon**: Open your project in Godot, go to `Project -> Project Settings -> Plugins`, and enable the `glTF Extras Plugin`.

### 📜 License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/lgxm3z/godot-gltf-extras/blob/main/LICENSE) file for more details.
