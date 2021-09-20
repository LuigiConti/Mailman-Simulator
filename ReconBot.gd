extends KinematicBody


var health = 3
var path = []
var path_ind = 0
const move_speed = 10
onready var nav = get_parent()
onready var main = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if path_ind < path.size():
		var move_vec = (path[path_ind] - global_transform.origin)
		if move_vec.length() < 0.1:
			path_ind += 1
		else:
			move_and_slide(move_vec.normalized() * move_speed, Vector3(0, 1, 0))
 
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_ind = 0

func take_damage(amount):
	health -= amount
	if health <= 0:
		get_tree().queue_delete(self)


func _on_DamageArea_area_entered(area):
	$SparkParticles.emitting = true
	#print('Entered Area %s'%(self))
	main.take_damage()
	$Timer.start()

func _on_Timer_timeout():
	$SparkParticles.emitting = true
	main.take_damage()


