extends Node


const HELLO_WORLD_UID: String = "uid://dvkekvy5gr6iu"

@export_file("*.gd") var code: String = HELLO_WORLD_UID
@export_range(0.0, 1.0, 0.1) var flush_delay: float = 0.1
@export_range(0, 10, 1) var time_precision: int = 3

var start_ticks: int
var end_ticks: int


func _ready() -> void:
    var code_script := load(code)
    var code_instance = code_script.new()
    code_instance.done.connect(_done, CONNECT_ONE_SHOT)

    start_ticks = Time.get_ticks_usec()
    code_instance.start()


func _done() -> void:
    end_ticks = Time.get_ticks_usec()
    var format_string: String = "%%.%df seconds" % time_precision
    print("Execution Time: " + format_string % Helpers.calculate_time_diff_from_ticks(start_ticks, end_ticks))

    # Delay a bit to ensure all output is flushed
    await get_tree().create_timer(flush_delay).timeout
    self.queue_free()
    await self.tree_exiting
    get_tree().quit()
