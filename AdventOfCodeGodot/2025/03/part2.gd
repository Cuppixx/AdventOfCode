extends AbstractBaseClass


func start() -> void:
    var banks: PackedStringArray = Helpers.text_file_to_array("res://2025/03/input.txt")

    var joltage: int = 0

    for bank: String in banks:
        var digits: Array[String] = []
        digits.append_array(bank.split(""))
        var needed: int = 12
        var result: String = ""
        var start_pos: int = 0

        while needed > 0:
            # End of slice = ensure enough digits remain
            var end_pos: int = digits.size() - (needed - 1)

            # slice window
            var segment: Array = digits.slice(start_pos, end_pos)
            var max_val: String = segment.max()

            # find absolute position of max
            var rel_pos: int = segment.find(max_val)
            var abs_pos: int = start_pos + rel_pos

            # append pick
            result += max_val

            # next scan must begin *after* the picked digit
            start_pos = abs_pos + 1
            needed -= 1

        #print("Bank joltage: %s" % result)
        joltage += int(result)

    print("Total joltage: %d" % joltage)
    self.done.emit()
