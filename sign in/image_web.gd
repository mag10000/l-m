extends ColorRect
class_name ImageWeb

@export_group("Main")
@export var url: String

@export_group("Refernces")
@export var image_tr: TextureRect
@export var image_download_api = HTTPRequest


func _ready() -> void:
	image_download_api.req_failed.connect(_on_image_download_api_req_failed)
	image_download_api.res_recived.connect(_on_image_download_api_res_recived)
	
	reset_ui()
	
	download_image()

func reset_ui() -> void:
	image_tr.texture = null
	image_tr.visible = false


func download_image() -> void:
	image_download_api.download(url)


func _on_image_download_api_req_failed() -> void:
	image_tr.texture = null
	image_tr.visible = false
	push_warning("Image download request cannot be made")


func _on_image_download_api_res_recived(
	result:int,
	response_code:int,
	body:PackedByteArray,
	image_load_method: String

) -> void:
	
	print(image_load_method)
	if result != HTTPRequest.RESULT_SUCCESS or response_code != 200:
		push_warning("Image could'nt be downloaded")
		return
	
	var image: Image = Image.new()
	var error: Error = FAILED
	
	if image_load_method != "":
		error = image.call(image_load_method,body)
	
	if error != OK:
		push_warning("Image cannot be loaded")
		return
	
	
	image_tr.texture = ImageTexture.create_from_image(image)
	image_tr.visible = true
