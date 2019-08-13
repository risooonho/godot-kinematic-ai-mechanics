extends Node

class_name CharacterPlayer

var me:Character = null

var camera : Camera = null
var point_and_click : bool = true

func _ready():
	me = get_parent()
	
	if me.controlled_by_player:
		camera = me.camera
		
		if point_and_click == true:
			camera = get_tree().get_root().find_node('Camera', true, false)
			
		set_physics_process(true)
		
	else:
		set_physics_process(false)
			

func _input(event):
	
	if not me.controlled_by_player:
		return
	
	# Point and Click Adventure!
	
#	if (event extends InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed):
	if (event.is_class("InputEventMouseButton") and event.button_index == BUTTON_LEFT and event.pressed):
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position)*100
		var end = me.navLevel.get_closest_point_to_segment(from, to)
		
		me.set_navigation_path(end)
			
func _physics_process(delta):
	pass