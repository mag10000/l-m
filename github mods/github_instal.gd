extends Button

@export var repo = "https://github.com/mag10000/MagnusTalk"
@export var branch = "Mag-Branch"
var usrn = OS.get_environment("USERNAME")
var folder = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	folder = repo.split("/")[repo.split("/").size() - 1] + "-" + branch


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	$HTTPRequest.download_file = "user://github_mod.zip"
	$HTTPRequest.request(repo + "/archive/refs/heads/" + branch + ".zip")

func extract_all_from_zip(from,to):
	var reader = ZIPReader.new()
	reader.open(from)

	# Destination directory for the extracted files (this folder must exist before extraction).
	# Not all ZIP archives put everything in a single root folder,
	# which means several files/folders may be created in `root_dir` after extraction.
	var root_dir = DirAccess.open(to)

	var files = reader.get_files()
	for file_path in files:
		# If the current entry is a directory.
		if file_path.ends_with("/"):
			root_dir.make_dir_recursive(file_path)
			continue

		# Write file contents, creating folders automatically when needed.
		# Not all ZIP archives are strictly ordered, so we need to do this in case
		# the file entry comes before the folder entry.
		root_dir.make_dir_recursive(root_dir.get_current_dir().path_join(file_path).get_base_dir())
		var file = FileAccess.open(root_dir.get_current_dir().path_join(file_path), FileAccess.WRITE)
		var buffer = reader.read_file(file_path)
		file.store_buffer(buffer)

func _on_http_request_request_completed(result, response_code, headers, body):
	DirAccess.make_dir_absolute("user://github_mod_folder")
	extract_all_from_zip($HTTPRequest.download_file,"user://github_mod_folder")
	print(ProjectSettings.load_resource_pack("user://github_mod.zip",true))
	print(DirAccess.get_directories_at("res://" + folder))
	print(FileAccess.get_file_as_string("res://" + folder + "/README.md"))
