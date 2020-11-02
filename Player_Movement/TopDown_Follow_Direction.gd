extends KinematicBody2D

#exporting some of these variables to make it easier to edit quickly.
export var MAX_SPEED = 500
export var ACCELERATION = 1000
var motion = Vector2.ZERO
export var rotation_speed = 0.1

func _physics_process(delta):
	var axis = get_input_left_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
		rotation = rotation
	else:
		apply_movement(axis * ACCELERATION * delta)
		rotation = lerp_angle(rotation, (axis.angle() + 1.57079633), .1)
	motion = move_and_slide(motion)

#you will need to note the direction input names. These have to be the same in the "project settings"
func get_input_left_axis():
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("PlMoveRight") - Input.get_action_strength("PlMoveLeft")
	axis.y = Input.get_action_strength("PlMoveDown") - Input.get_action_strength("PlMoveUp")
	return axis.normalized() #to not move faster along diagonal direction
	
func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO
	
func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
