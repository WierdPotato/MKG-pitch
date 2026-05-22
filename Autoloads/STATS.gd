extends Node

var duration : int
var shots_fired : int
var shots_missed : int
var enemies_hit : int
var blocked : int
var hits_recieved : int
var crashes : int
var kills : int

func reset_stats()->void:
	duration = 0
	shots_fired = 0
	shots_missed = 0
	enemies_hit = 0
	blocked = 0
	hits_recieved = 0
	crashes = 0
	kills = 0

func return_time()->String:
	var minutes: int = floori(duration / 60.0)
	var seconds: int = duration % 60
	return "%02d:%02d" % [minutes, seconds]
