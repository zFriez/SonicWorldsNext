extends Control

@onready var countdownLabel = $Timer/CountdownLabel
@onready var timer = $Timer
@onready var countdownMusic = $"../../../CountdownMusic"
@onready var deathSfx = $"../../../DeathSound"
@onready var continueSfx = $"../../../ContinueSound"

var titleScreen = preload("res://Scene/Presentation/Title.tscn")
var continueConfirmed
var count = 0
var counter = 0

func _ready():
	continueConfirmed = load("res://Scene/Zones/"+str(Global.currentZone)+".tscn")
	countdownLabel.text = "1"+str(count)
	countdownMusic.play()
	timer.start()
	
func _input(event):
	if (event.is_action_pressed("gm_action") and count >= 1):
		timer.stop()
		countdownMusic.stop()
		continueSfx.play()
		Global.reset_values()
		if (Global.currentZone != "" or Global.currentZone != null):
			Global.main.change_scene_to_file(continueConfirmed,"FadeOut","FadeOut",1)
		else:
			Global.main.change_scene_to_file(titleScreen,"FadeOut","FadeOut",1)
	
func _on_timer_timeout():
	counter += 1
	if (counter == 10):
		timer.stop()
		countdownMusic.stop()
		deathSfx.play()
		get_tree().create_timer(1)
		Global.main.change_scene_to_file(titleScreen,"FadeOut","FadeOut",1)
	elif (count == 0):
		count = 9
		countdownLabel.text = "0"+str(count)
		
	if (count == 9):
		countdownLabel.text = "0"+str(count)
		count -= 1
		timer.start()
	elif (count < 9):
		countdownLabel.text = "0"+str(count)
		count -= 1
		timer.start()
