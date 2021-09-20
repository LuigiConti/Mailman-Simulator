extends RigidBody

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	pass

func _on_RigidBody_body_entered(body):
	print("Hit!")
	get_tree().queue_delete(self)
