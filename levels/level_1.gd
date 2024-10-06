extends Node2D

@onready var coins: Node = $Collectables/Coins
@onready var shards: Node = $Collectables/Shards
@onready var diamond: Area2D = $Collectables/Diamond

func _process(delta: float) -> void:
	var shards_count = shards.get_child_count()
	print(shards_count)
	
	if (shards_count == 0 and is_instance_valid(diamond)):
		diamond.show()
