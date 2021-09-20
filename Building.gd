extends Spatial

onready var shop0  = $Shop0
onready var shop1  = $Shop1
onready var phone  = $Phone
onready var house  = $House

onready var buildings = [shop0,shop1,phone,house]

# Called when the node enters the scene tree for the first time.
func _ready():
	for building in buildings:
			building.visible = false

func randomize_building():
	for building in buildings:
			building.visible = false
	randomize()
	var randint = randi() % buildings.size()
	buildings[randint].visible = true
