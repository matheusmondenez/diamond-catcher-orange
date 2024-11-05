extends Node2D

@export var speed := 2.0
@export var radius := 60.0

@onready var chain: Node2D = $"../Chain"

var angle := .0

func _physics_process(delta: float) -> void:
	angle += delta
	position = Vector2(sin(angle * speed) * radius, cos(angle * speed) * radius)
	
	var link_radius = 0
	
	for links in chain.get_children():
		links.position = Vector2(sin(angle * speed) * radius / chain.get_child_count(), cos(angle * speed) * radius / chain.get_child_count()) * link_radius
		link_radius += 1

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Orange" and body.has_method("take_damage"):
		body.take_damage(Vector2(200, -200))
