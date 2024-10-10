extends Area2D

@onready var sprite: Sprite2D = $Sprite
@onready var collision: CollisionShape2D = $Collision

func _ready() -> void:
	collision.shape.set("size", sprite.get_rect().size)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Orange" and body.has_method("take_damage"):
		body.take_damage(Vector2(0, -200))
