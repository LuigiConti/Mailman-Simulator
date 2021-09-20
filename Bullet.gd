extends Area

var g = Vector3.DOWN * 12
var bullet_speed = 35
var velocity = Vector3.ZERO
export var damage = 1

var rotx = 0
var roty = 0
var rotz = 0
var rotVelx = 0
var rotVely = 0
var rotVelz = 0

onready var particles = preload("res://BoxParticles.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rotx = rand_range(0,360)
	rotate_x(rotx)
	roty = rand_range(0,360)
	rotate_y(roty)
	rotz = rand_range(0,360)
	rotate_z(rotz)
	

func _physics_process(delta):
	velocity += g*delta
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta
	
	randomize()
	rotVelz = rand_range(-10,-8)
	rotz += rotVelz * delta
	rotz = clamp(rotz,-360,360)
	rotate_z(rotz)
	
	randomize()
	rotVelx = rand_range(-5,0)
	rotx += rotVelx * delta
	rotx = clamp(rotx,-360,360)
	rotate_x(rotx)
	
	randomize()
	rotVely = rand_range(-5,0)
	roty += rotVely * delta
	roty = clamp(roty,-360,360)
	rotate_y(roty)


func _on_Area_body_entered(body):
	var particle = particles.instance()
	particle.transform = global_transform
	particle.rotation = Vector3(0,0,0)
	get_parent().add_child(particle)
	
	if body.is_in_group("Enemies"):
		 body.take_damage(damage)
	get_tree().queue_delete(self)
