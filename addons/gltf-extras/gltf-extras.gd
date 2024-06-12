@tool
extends EditorPlugin

var importer

func _enter_tree() -> void:
	importer = ExtrasImporter.new()
	GLTFDocument.register_gltf_document_extension(importer)
	pass


func _exit_tree() -> void:
	GLTFDocument.unregister_gltf_document_extension(importer)
	pass

class ExtrasImporter extends GLTFDocumentExtension:
	func is_vector3(v:Variant) -> bool:
		return typeof(v) == TYPE_ARRAY and v.size() == 3
	
	func is_vector4(v:Variant) -> bool:
		return typeof(v) == TYPE_ARRAY and v.size() == 3

	func _import_post(state: GLTFState, root: Node) -> Error:

		# print(state.json)

		var lights_json : Array = state.json.get("extensions", {}).get("KHR_lights_punctual", {}).get("lights", [])
		var materials_json : Array = state.json.get("materials", [])

		var nodes_json : Array = state.json.get("nodes", [])
		for i in nodes_json.size():
			var node = state.get_scene_node(i)
			if !node:
				continue

			if node is Light3D:
				# clear all meta
				for key in node.get_meta_list():
					node.set_meta(key, null)

				var light = lights_json[nodes_json[i].get("extensions", {}).get("KHR_lights_punctual", {}).get("light", -1)]	
				
				for key in light.get("extras", {}).keys():
					node.set(key, light.get("extras", {}).get(key))

			if node is ImporterMeshInstance3D:

				var arrayMesh: ArrayMesh = node.mesh.get_mesh();

				for j in arrayMesh.get_surface_count():
					var material:Material = arrayMesh.surface_get_material(j)

					# clear all meta
					for key in material.get_meta_list():
						material.set_meta(key, null)
					
					for _m in materials_json.size():
						if materials_json[_m].get("name") == material.resource_name:
							for extras in materials_json[_m].get("extras", {}).keys():
								
								if extras == "albedo_color":
									if is_vector3(materials_json[_m].get("extras", {}).get(extras)):
										material.set(extras, Color(materials_json[_m].get("extras", {}).get(extras)[0], materials_json[_m].get("extras", {}).get(extras)[1], materials_json[_m].get("extras", {}).get(extras)[2]))
									elif is_vector4(materials_json[_m].get("extras", {}).get(extras)):
										material.set(extras, Color(materials_json[_m].get("extras", {}).get(extras)[0], materials_json[_m].get("extras", {}).get(extras)[1], materials_json[_m].get("extras", {}).get(extras)[2], materials_json[_m].get("extras", {}).get(extras)[3]))

								elif is_vector3(materials_json[_m].get("extras", {}).get(extras)):
									material.set(extras, Vector3(materials_json[_m].get("extras", {}).get(extras)[0], materials_json[_m].get("extras", {}).get(extras)[1], materials_json[_m].get("extras", {}).get(extras)[2]))
								else :
									material.set(extras, materials_json[_m].get("extras", {}).get(extras))


		return OK
