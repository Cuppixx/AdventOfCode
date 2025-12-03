extends AbstractBaseClass


func start() -> void:
    var banks: PackedStringArray =  Helpers.text_file_to_array("res://2025/03/input.txt")

    var joltage: int = 0
    var batteries: Array[String] = []

    var max_joltage_1_pos: int
    var max_joltage_1: String
    var max_joltage_2: String

    for bank: String in banks:
        batteries.clear()
        batteries.append_array(bank.split(""))

        max_joltage_1_pos = batteries.find(batteries.max())
        max_joltage_1 = batteries.get(max_joltage_1_pos)

        # If max is not the last element, look for the second max in the remaining slice
        if not max_joltage_1_pos + 1 == batteries.size():
            batteries = batteries.slice(max_joltage_1_pos + 1, batteries.size())
            max_joltage_2 = batteries.get(batteries.find(batteries.max()))
            joltage += int(max_joltage_1 + max_joltage_2)

        # Else, remove max and find the second max in the remaining elements but combine in reverse order
        else:
            batteries.pop_back()
            max_joltage_2 = batteries.get(batteries.find(batteries.max()))
            joltage += int(max_joltage_2 + max_joltage_1)

    print("Total Joltage: %d" % joltage)
    self.done.emit()
