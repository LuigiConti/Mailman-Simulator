extends CPUParticles

var life_time = 1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = life_time
	$Timer.one_shot = true
	$Timer.start()

func _on_Timer_timeout():
	get_tree().queue_delete(self)
