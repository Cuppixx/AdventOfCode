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
        pointer += direction * step
        pointer = wrapi(pointer, MIN_NUM, MAX_NUM)
        if pointer == 0:
            zero_count += 1

        #print("The dial is rotated %s%d to point at %d" % [line.substr(0, 1), step, pointer])

    print("Zeroes encountered: %d" % zero_count)

    self.done.emit()
