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

	func _import_post(state: GLTFState, root: Node) -> Error:
		return OK
