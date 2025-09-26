extends TileMapLayer



func _ready() -> void:
	pass
	#generate_new_world(randi(),1024)

func generate_new_world(wseed,size):
	seed(wseed)
	
	print("remove old trees")
	
	for i in $Trees.get_children():
		i.queue_free()
	
	var tMap = $Generation.generate_tilemap(size,randi())
	print("world gen took" + str(Time.get_ticks_msec()/1000.0))
	for x in tMap.size():
		for y in tMap.size():
			if tMap[x][y] == "grassland":
				$".".set_cell(Vector2i(x,y),0,Vector2i(randi_range(0,9),0))
			elif tMap[x][y] == "forest":
				$".".set_cell(Vector2i(x,y),0,Vector2i(randi_range(1,9),1))
			elif tMap[x][y] == "pine forest":
				$".".set_cell(Vector2i(x,y),0,Vector2i(randi_range(1,4),2))
			elif tMap[x][y] == "taiga":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,3))
			elif tMap[x][y] == "rain forest":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,4))
			elif tMap[x][y] == "tropical rainforest":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,5))
			elif tMap[x][y] == "savanna":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,6))
			elif tMap[x][y] == "cold desert":
				$".".set_cell(Vector2i(x,y),0,Vector2i(randi_range(0,9),7))
			elif tMap[x][y] == "hot desert":
				$".".set_cell(Vector2i(x,y),0,Vector2i(randi_range(0,9),8))
			elif tMap[x][y] == "tundra":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,9))
			elif tMap[x][y] == "asphalt":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,10))
			elif tMap[x][y] == "lava":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,11))
			elif tMap[x][y] == "salt":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,12))
			elif tMap[x][y] == "ice plain":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,13))
			elif tMap[x][y] == "beach":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,14))
			elif tMap[x][y] == "swamp":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,15))
			elif tMap[x][y] == "rocky shore":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,16))
			elif tMap[x][y] == "sea ice":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,17))
			elif tMap[x][y] == "cool sea":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,18))
			elif tMap[x][y] == "warm sea":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,19))
			elif tMap[x][y] == "reef":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,20))
			elif tMap[x][y] == "ocean":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,21))
			elif tMap[x][y] == "sulphur":
				$".".set_cell(Vector2i(x,y),0,Vector2i(0,22))
	print("tileset took" + str(Time.get_ticks_msec()/1000.0))
	
	var spriteMap = $Generation.generate_spritemap(tMap)
	var loadedTree = load("res://SpriteScenes/pine.tscn")
	for i in spriteMap[0].size():
		var newTree = loadedTree.instantiate()
		newTree.position = ((spriteMap[0][i]) * 32) + Vector2i(16,-16) + Vector2i(randi_range(-8,8),randi_range(-8,8))
		$Trees.add_child(newTree)
	loadedTree = load("res://SpriteScenes/forest.tscn")
	for i in spriteMap[1].size():
		var newTree = loadedTree.instantiate()
		newTree.position = ((spriteMap[1][i]) * 32) + Vector2i(16,-16) + Vector2i(randi_range(-8,8),randi_range(-8,8))
		$Trees.add_child(newTree)
	loadedTree = load("res://SpriteScenes/cactus.tscn")
	for i in spriteMap[2].size():
		var newTree = loadedTree.instantiate()
		newTree.position = ((spriteMap[2][i]) * 32) + Vector2i(16,-16) + Vector2i(randi_range(-8,8),randi_range(-8,8))
		$Trees.add_child(newTree)
	loadedTree = load("res://SpriteScenes/boreal.tscn")
	for i in spriteMap[3].size():
		var newTree = loadedTree.instantiate()
		newTree.position = ((spriteMap[3][i]) * 32) + Vector2i(16,-16) + Vector2i(randi_range(-8,8),randi_range(-8,8))
		$Trees.add_child(newTree)
	
	print("trees took" + str(Time.get_ticks_msec()/1000.0))
