extends BaseStage

const DIAMOND_SCENE = preload("res://collectables/diamond.tscn")

@onready var transition = get_node("Transition/Fill")
@onready var transition_animation = get_node("Transition/Fill/Animation")

@export_category("Transition")
@export_enum("Diamond", "Spot Player", "Spot Center", "Vertical Bar", "Horizontal Bar") var transition_type = 0
@export_range(0.0, 2.0) var duration = 1.0

func _physics_process(delta: float) -> void:
	if Globals.shards == 5 and is_instance_valid(diamond):
		spawn_diamond()

func spawn_diamond() -> void:
	diamond.get_node("Collision").disabled = false
	diamond.show()
