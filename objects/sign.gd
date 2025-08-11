extends Area2D

@export var sign_id: String
@export var message: String
@export var interactive: bool = false  # Flag to switch modes

# Simple dialogue data (example)
var dialogue = [
	"Stop staring",
	"What? Have you never seen a sign before?",
	"A good backstory has maximum twentie words.",
	"Its a pune, a play on words"
]

var current_line = 0
var message_label: Label

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	
	# Assume a CanvasLayer + Label called "CanvasLayer/SignMessageLabel" exists in scene
	message_label = get_tree().current_scene.get_node("CanvasLayer/SignMessageLabel")
	if message_label == null:
		push_error("SignMessageLabel node not found in CanvasLayer!")



func _on_body_entered(body):
	if body.name == "Player":
		
		if interactive:
			current_line = 0
			_show_dialogue()
			print_debug()
		else:
			message_label.text = "Sign ID: %s\n%s" % [sign_id, message]
			message_label.visible = true
			print_debug()
			print([message_label.visible, message]) #Hmmmm logiken verkar det inte vara fel på. Måste vara hur det renderas

func _on_body_exited(body):
	if body.name == "Player":
		message_label.visible = false
		print_debug()

func _input(event):
	# If interactive and player presses "ui_accept" (Enter/Space by default), advance dialogue
	if interactive and message_label.visible and event.is_action_pressed("ui_accept"):
		advance_dialogue()
		print_debug()

func _show_dialogue():
	message_label.text = dialogue[current_line]
	message_label.visible = true
	print_debug()

func advance_dialogue():
	current_line += 1
	if current_line < dialogue.size():
		_show_dialogue()
		print_debug()
	else:
		message_label.visible = false
		print("Dialogue ended")
		print_debug()
