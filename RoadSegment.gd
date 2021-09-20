extends StaticBody

onready var b1 = $Road/Building1
onready var b2 = $Road/Building2
onready var b3 = $Road/Building3
onready var b4 = $Road2/Building4
onready var b5 = $Road2/Building5
onready var b6 = $Road2/Building6
onready var buildings = [b1,b2,b3,b4,b5,b6]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize_buildings()

func randomize_buildings():
	
	for b in buildings:
			b.visible = false
	
	randomize()
	var numBuildings = randi() % buildings.size() + 3
	
	if numBuildings <= buildings.size():
		var i = 0
		var arr = [0,1,2,3,4,5]
		while i < numBuildings:
			randomize()
			var randint = randi() % buildings.size()
			if arr[randint] != null:
				buildings[randint].visible = true
				buildings[randint].randomize_building()
				arr[randint] = null
				i+=1
