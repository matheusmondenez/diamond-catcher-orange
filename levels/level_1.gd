extends Node2D

@onready var coins: Node = $Collectables/Coins
@onready var diamond: Area2D = $Collectables/Diamond

func _process(delta: float) -> void:
	var coins_count = coins.get_child_count()
	
	if (coins_count == 0 and is_instance_valid(diamond)):
		diamond.show()
