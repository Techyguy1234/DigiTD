extends Node



func generate_tilemap(size:int, worldseed:int = 0) -> Array:
	print("Starting Tilemap Gen")
	
	#Configuration for Noisemaps
	var tempNoiseMap := FastNoiseLite.new()
	tempNoiseMap.seed = worldseed
	
	var heightNoiseMap := FastNoiseLite.new()
	heightNoiseMap.seed = worldseed * 2
	heightNoiseMap.noise_type = FastNoiseLite.TYPE_VALUE
	
	#Initialize tempMap array and heightMap array
	print("Generating Temperature Map...")
	var tempMap = []
	for x in size:
		tempMap.append([])
		for y in size:
			tempMap[x].append(roundi(tempNoiseMap.get_noise_2d(x,y)*8))
	print("Done Generating Temperature Map")
	
	print("Generating Height Map...")
	var heightMap = []
	for x in size:
		heightMap.append([])
		for y in size:
			heightMap[x].append(roundi(heightNoiseMap.get_noise_2d(x,y)*10+2))
	print("Done Generating Height Map")
	
	#Combine Temperature and Height data into a biome map
	print("Generating Biome map")
	#TODO for future jacoby: I appologize for this nested if statement
	var biomeMap = []
	
	var currentHeight:int
	var currentTemp:int
	
	for x in size:
		biomeMap.append([])
		for y in size:
			biomeMap[x].append(null)
			currentHeight = heightMap[x][y]
			currentTemp = tempMap[x][y]
			if (0 >= currentTemp && currentTemp >= -3 and currentHeight == -1) or (-1 >= currentTemp && currentTemp >= -3 and currentHeight == -2):
				biomeMap[x][y] = "grassland"
			
			elif (0 >= currentTemp && currentTemp >= -2 and currentHeight == 0) or (0 >= currentTemp && currentTemp >= -1 and currentHeight == 1):
				biomeMap[x][y] = "forest"
			
			elif (currentTemp == -2 && currentHeight == 1) or (-1 >= currentTemp && currentTemp >= -3 and currentHeight == 2):
				biomeMap[x][y] = "pine forest"
			
			elif (currentTemp == -3 and 1 >= currentHeight && currentHeight >= 0) or (currentTemp == -4 and 2 >= currentHeight && currentHeight >= 1):
				biomeMap[x][y] = "taiga"
			
			elif (currentTemp == 1 and currentHeight == 1) or (1 >= currentTemp && currentTemp >= 0 and currentHeight == 2):
				biomeMap[x][y] = "rain forest"
			
			elif (currentTemp == 2 and 2 >= currentHeight && currentHeight >= 1):
				biomeMap[x][y] = "tropical rainforest"
			
			elif (1 >= currentTemp && currentTemp >= 0 and currentHeight == -2) or (2 >= currentTemp && currentTemp >= 1 and 0 >= currentHeight && currentHeight >= -1):
				biomeMap[x][y] = "savanna"
			
			elif (-1 >= currentTemp && currentTemp >= -4 and currentHeight == -3) or (-2 >= currentTemp && currentTemp >= -4 and currentHeight == -4):
				biomeMap[x][y] = "cold desert"
			
			elif (2 >= currentTemp && currentTemp >= -1 and currentHeight == -4) or (3 >= currentTemp && currentTemp >= 0 and currentHeight == -3) or (3 >= currentTemp && currentTemp >= 2 and currentHeight == -2) or (currentTemp == 3 and 0 >= currentHeight && currentHeight >= -1):
				biomeMap[x][y] = "hot desert"
			
			elif (currentTemp == -4 and 0 >= currentHeight && currentHeight >= -2):
				biomeMap[x][y] = "tundra"
			
			elif (currentTemp == 3 and currentHeight == -4) or (currentTemp == 4 and 2 >= currentHeight && currentHeight >= -4):
				biomeMap[x][y] = "asphalt"
			
			elif (currentTemp >= 5 and currentHeight <= 2):
				biomeMap[x][y] = "lava"
			
			elif (4 >= currentTemp && currentTemp >= -4 and currentHeight <= -5):
				biomeMap[x][y] = "salt"
			
			elif (currentTemp <= -5 and currentHeight <= 2):
				biomeMap[x][y] = "ice plain"
			
			elif (currentTemp == 3 and 3 >= currentHeight && currentHeight >= 1) or (2 >= currentTemp && currentTemp >= 1 and currentHeight == 3):
				biomeMap[x][y] = "beach"
			
			elif (0 >= currentTemp && currentTemp >= -1 and currentHeight == 3):
				biomeMap[x][y] = "swamp"
			
			elif (-2 >= currentTemp && currentTemp >= -4 and currentHeight == 3):
				biomeMap[x][y] = "rocky shore"
			
			elif (-5 >= currentTemp and currentHeight >= 3):
				biomeMap[x][y] = "sea ice"
			
			elif (-2 >= currentTemp && currentTemp >= -4 and (currentHeight == 4 or currentHeight == 5 or currentHeight == 6)):
				biomeMap[x][y] = "cool sea"
			
			elif (1 >= currentTemp && currentTemp >= -1 and (currentHeight == 4 or currentHeight == 5 or currentHeight == 6)):
				biomeMap[x][y] = "warm sea"
			
			elif (3 >= currentTemp && currentTemp >= 2 and (currentHeight == 4 or currentHeight == 5 or currentHeight == 6)):
				biomeMap[x][y] = "reef"
			
			elif (4 >= currentTemp && currentTemp >= -4 and currentHeight >= 5):
				biomeMap[x][y] = "ocean"
			
			elif (currentTemp == 4 and 4 >= currentHeight && currentHeight >= 3) or (currentTemp >= 5 and currentHeight >= 3):
				biomeMap[x][y] = "sulphur"
	return biomeMap

func generate_spritemap(biomeMap:Array):
	var spriteMap = []
	
	#generate trees
	spriteMap.append([])
	spriteMap.append([])
	spriteMap.append([])
	for x in biomeMap.size():
		for y in biomeMap[x].size():
			if biomeMap[x][y] == "pine forest" and randi_range(0,1) == 1:
				spriteMap[0].append(Vector2i(x,y))
			elif biomeMap[x][y] == "forest" and randi_range(0,1) == 1:
				spriteMap[1].append(Vector2i(x,y))
			elif (biomeMap[x][y] == "cold desert" or biomeMap[x][y] == "hot desert") and randi_range(0,8) == 1:
				spriteMap[2].append(Vector2i(x,y))
	
	return spriteMap
