extends AbstractBaseClass

const MIN_NUM: int = 0
const MAX_NUM: int = 100
var pointer: int = 50
var zero_count: int = 0
var directions: Dictionary[String, int] = {
    "L": -1,
    "R": 1,
}
var direction: int
var step: int


func start() -> void:
    var lines: Array[String] = Helpers.text_file_to_array("res://2025/01/input.txt")

    #print("The dial starts by pointing at %d" % pointer)

    for line in lines:
        direction = directions[line.substr(0, 1)]
        step = int(line.substr(1, line.length() - 1))

        zero_count += _count_zero_crossings(pointer, direction, step)

        pointer += direction * step
        pointer = wrapi(pointer, MIN_NUM, MAX_NUM)

        #print("The dial is rotated %s%d to point at %d; during this rotation, it points at zero %d times" % [
        #    line.substr(0, 1),
        #    step,
        #    pointer,
        #    _count_zero_crossings(pointer - direction * step, direction, step)
        #])

    print("Zeroes encountered: %d" % zero_count)

    self.done.emit()


func _count_zero_crossings(old_ptr: int, dir: int, stp: int) -> int:
    var size: int = MAX_NUM
    var raw := old_ptr + dir * stp

    var count: int

    if dir == directions["R"]:
        var raw_floor := int(floor(float(raw) / float(size)))
        var old_floor := int(floor(float(old_ptr) / float(size)))
        count = raw_floor - old_floor

    if dir == directions["L"]:
        var raw_ceil := int(ceil(float(raw) / float(size)))
        var old_ceil := int(ceil(float(old_ptr) / float(size)))
        count = old_ceil - raw_ceil

    return max(count, 0)

