class_name Gun extends Pickable

@export var bullethole : PackedScene
@export var gun_name : String
@export var gun_barrel : Node3D

var bullet_trail = preload("res://bullets/bullet_trail.tscn")
var instance


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


