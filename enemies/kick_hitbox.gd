extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.name == "KickArea":
		get_parent().animation.play("hurting")
