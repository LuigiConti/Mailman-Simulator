extends Node

onready var road1 = $RoadSegment1
onready var road2 = $RoadSegment2
onready var road3 = $RoadSegment3
onready var road4 = $RoadSegment4
onready var road5 = $RoadSegment5
onready var road6 = $RoadSegment6
onready var road7 = $RoadSegment7
onready var road8 = $RoadSegment8
onready var road9 = $RoadSegment9
onready var road10 = $RoadSegment10
onready var road11 = $RoadSegment11
onready var road12 = $RoadSegment12
onready var roads = [road1,road2,road3,road4,road5,road6,road7,road8,road9,road10,road11,road12]

onready var carScene = preload("res://Car.tscn")
onready var reconScene = preload("res://ReconBot.tscn")

onready var cam = $MailTruck/Cam
onready var muzzle = $MailTruck/Cam/Muzzle
var V_LOOK_SENS = .2
var H_LOOK_SENS = .2

const ROAD_SPEED = 10
var speed = 20

export var health = 100
onready var healthBar = $MarginContainer/HealthBar

const MAX_AMMO = 12
var ammo = 12
onready var ammoLabel = $MarginContainer/HealthBar/Label
onready var popup =$MarginContainer/OutOfAmmo

onready var bulletScn = preload("res://Bullet.tscn")

onready var reach = $MailTruck/Cam/Camera/Reach

# Called when the node enters the scene tree for the first time.
func _ready():
	ammo = 12
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	healthBar.max_value = health
	ammoLabel.text = "Ammo: %s"%(ammo) + "/%s"%(MAX_AMMO)
	
	for enemy in get_tree().get_nodes_in_group('Enemies'):
		randomize()
		var offset = rand_range(-4,4)
		enemy.move_to(get_node("Target").translation +  Vector3(0,0,offset))

func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_LOOK_SENS
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -40, 55)
		cam.rotation_degrees.y -= event.relative.x * H_LOOK_SENS
		#cam.rotation_degrees.y = clamp(cam.rotation_degrees.y, 20, 160)
	
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_left"):
			if ammo > 0:
				var b = bulletScn.instance()
				add_child(b)
				b.transform = muzzle.global_transform
				b.velocity = -b.transform.basis.z * b.bullet_speed
				ammo -= 1
				ammoLabel.text = "Ammo: %s"%(ammo) + "/%s"%(MAX_AMMO)
			else:
				popup.visible = true
	
	if event.is_action_pressed("reload_ammo"):
		if reach.is_colliding():
			ammo = MAX_AMMO
			ammoLabel.text = "Ammo: %s"%(ammo) + "/%s"%(MAX_AMMO)
			popup.visible = false

func _process(delta):
	for road in roads:
		road.translation.x += ROAD_SPEED * delta
		if road.translation.x > 120:
			road.translation.x -= (roads.size()) *20
			road.randomize_buildings()

func spawn_enemy():
	var enemy = reconScene.instance()
	randomize()
	var car = randi()%2 # either 0 or 1
	if car:
		enemy = carScene.instance()
	
	
	var offset = rand_range(-4,4)
	enemy.translation = $Spawn.translation + Vector3(0,0,offset)
	
	randomize()
	offset = rand_range(-3.5,3.5)
	$Navigation.add_child(enemy)
	enemy.move_to(get_node("Target").translation +  Vector3(0,0,offset))

func _on_Timer_timeout():
	spawn_enemy()
	if $Timer.wait_time >= 1:
		$Timer.wait_time -= .2

func take_damage():
	health -= 4.3
	healthBar.value = health
	if health <= 0:
		game_over()

func game_over():
	print('GAME OVER!')
	get_tree().change_scene("res://GameOver.tscn")

