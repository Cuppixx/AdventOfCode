extends AbstractBaseClass

var num_str: String
var length: int
var pattern: String
var repetitions: int
var reconstructed: String

func start() -> void:
    var ranges: PackedStringArray = Helpers.text_file_to_array("res://2025/02/input.txt", ",")

    #print("Total ranges to process: ", ranges.size())

    var sum: int = 0
    var bounds: PackedStringArray
    var lower: int
    var upper: int
    var num_range: String

    for idx in ranges.size():
        num_range = ranges[idx]
        bounds = num_range.split("-")
        lower = int(bounds[0])
        upper = int(bounds[1])
        #print("Processing range %d/%d: %d to %d" % [idx + 1, ranges.size(), lower, upper])
        for num in range(lower, upper + 1):
            sum += _sequence_number(num)

    print("Invalid IDs sum: ", sum)

    self.done.emit()


@warning_ignore_start("integer_division")
func _sequence_number(num: int) -> int:
    num_str = str(num)
    length = num_str.length()

    if num_str.begins_with("0"):
        return 0

    # Try all possible pattern lengths from 1 to length/2
    for pattern_len in range(1, int(length / 2) + 1):
        # Check if the total length is divisible by pattern length
        if length % pattern_len == 0:
            pattern = num_str.substr(0, pattern_len)
            repetitions = length / pattern_len

            if repetitions >= 2 and repetitions % 2 == 0: # part 1
            #if repetitions >= 2: # part2
                reconstructed = ""
                for i in range(repetitions):
                    reconstructed += pattern

                if reconstructed == num_str:
                    #print("Found sequence number: ", num_str)
                    return int(num_str)

    return 0
@warning_ignore_restore("integer_division")
