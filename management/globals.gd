extends Node

var shards := 0
var coins := 0
var score := 0
var lives := 3
var hearts := 3

var player = null
var player_start_position = null
var current_checkpoint = null

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
	else:
		player.global_position = player_start_position.global_position
