class_name Helpers extends Resource


static func text_file_to_array(path: String) -> Array[String]:
    var file := FileAccess.open(path, FileAccess.READ)
    if file == null:
        push_error("Failed to open file: %s" % path)
        return []
    var lines: Array[String] = []
    while not file.eof_reached():
        lines.append(file.get_line())
    file.close()
    return lines
