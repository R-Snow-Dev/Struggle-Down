##@tutorial: https://youtu.be/lWQPT1uk_Vk

extends Node

var sounds: Dictionary = {} ## Storage for all of the sfx sounds
var music: Dictionary = {} ## Storage for all of the music, background and flying

var sfx_volume := 1.0 ## Louded volume for all of the SFX
var music_volume := 1.0 ## Loudest volume for all of the music

## Method calls all of the preload audios
func _ready() -> void:
	create_sound('Hover', preload("res://assets/Sounds/UI/hover.wav"), 'UI')
	create_sound('Select', preload("res://assets/Sounds/UI/select1.wav"), 'UI')
	create_sound('Melee', preload("res://assets/Sounds/AtkSFX/melee.wav"), 'PFX')
	create_sound('Hit1', preload("res://assets/Sounds/damaged/hit1.wav"), 'PFX')
	create_sound('Hit2', preload("res://assets/Sounds/damaged/hit2.wav"), 'PFX')
	create_sound('Hit3', preload("res://assets/Sounds/damaged/hit3.wav"), 'PFX')
	create_sound('EnemyDamaged', preload("res://assets/Sounds/damaged/enemydamaged.wav"))
	create_sound('FS1', preload("res://assets/Sounds/Footsteps/footstep1.wav"))
	create_sound('FS2', preload("res://assets/Sounds/Footsteps/footstep3.wav"))
	create_sound('SlimeStep1', preload("res://assets/Sounds/Footsteps/slimestep1.wav"))
	create_sound('SlimeStep2', preload("res://assets/Sounds/Footsteps/slimestep2.wav"))
	create_sound('SlimeStep3', preload("res://assets/Sounds/Footsteps/slimestep3.wav"))
	create_sound('TinyStep1', preload("res://assets/Sounds/Footsteps/tinystep1.wav"))
	create_sound('TinyStep2', preload("res://assets/Sounds/Footsteps/tinystep2.wav"))
	create_sound('TinyStep3', preload("res://assets/Sounds/Footsteps/tinystep3.wav"))
	create_sound('KSCrash', preload("res://assets/Sounds/KS/crash.wav"))
	create_sound('KSJump', preload("res://assets/Sounds/KS/jump.wav"))
	create_sound('KSCharge', preload("res://assets/Sounds/KS/KsCharge.wav"))
	create_sound('KSDamaged', preload("res://assets/Sounds/KS/KsDamaged.wav"))
	create_sound('KSLand', preload("res://assets/Sounds/KS/landingboom.wav"))
	create_sound('GetWeapon', preload("res://assets/Sounds/Environment/getWeapon.wav"))
	create_sound('Pause', preload("res://assets/Sounds/Environment/pause.wav"))
	create_sound('Unpause', preload("res://assets/Sounds/Environment/unpause.wav"))
	
## Method creates sounds and adds them to the corresponding dictionary
func create_sound(name: String, stream: AudioStream, bus: String = "SFX") -> void:
	var sound_player = AudioStreamPlayer.new()
	sound_player.stream = stream
	sound_player.bus = bus
	sound_player.autoplay = false
	sound_player.volume_db = linear_to_db(bus == "SFX" and sfx_volume or music_volume)
	add_child(sound_player)
	if bus == "SFX" or 'UI' or 'PFX':
		sounds[name] = sound_player
	else:
		music[name] = sound_player
	
	
## If the sound name is found in either the sounds dictionary or music dictionary
## Play it
func play_sound(name: String) -> void:
	if sounds.has(name):
		sounds[name].play()
	elif music.has(name) and !music[name].playing:
		music[name].play()

## If the sound name is found in either the sounds dictionary or music dictionary
## Stop it
func stop_sound(name: String) -> void:
	if music.has(name):
		music[name].stop()
	if sounds.has(name):
		sounds[name].stop()

## Method continously loops through the music dictionary and if a music has stopped then
## it starts it over again
## flying boolean variable skips it if it is not in play
func _process(_delta: float) -> void:
	for audioName in music:
		if music[audioName].playing: continue
		music[audioName].play()
