class_name Helpers extends Resource


static func calculate_time_diff_from_ticks(start_ticks: int, end_ticks: int) -> float:
    return (end_ticks - start_ticks) / 1000000.0 # Convert microseconds to seconds


static func text_file_to_array(path: String, seperator: String = "") -> PackedStringArray:
    var file := FileAccess.open(path, FileAccess.READ)

    if file == null:
        push_error("Failed to open file: %s" % path)
        return []

    var array: PackedStringArray = []

    if seperator.is_empty():
        while not file.eof_reached():
            array.append(file.get_line())
    else:
        var content: String = file.get_as_text()
        array = content.split(seperator)

    file.close()
    return array
