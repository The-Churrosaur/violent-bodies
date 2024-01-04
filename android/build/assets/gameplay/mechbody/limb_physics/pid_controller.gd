
## provides tuned outputs.
## expects to be called repeatedly by same object (logs inputs for sum/dx)
class_name PidController
extends Node


@export var p_tune = 0.5
@export var i_tune = 0.5
@export var d_tune = 0.5

## how many iterations to record, 
## area and slope calculated over this span
@export var log_size = 20

# logs error over time
var input_log = []


## returns the coefficient -
## error is actual - current
func solve(error : float) -> float:
	
	# slow but eh
	input_log.push_back(error)
	if input_log.size() > log_size: input_log.pop_front()
	
	var kp = _solve_p(error)
	var ki = _solve_i(error)
	var kd = _solve_d(error)
	
	return kp + ki + kd


func _solve_p(error):
	return error * p_tune


func _solve_i(error):
	var sum = 0
	for i in input_log: sum += i
	return sum * i_tune



func _solve_d(error):
	var a = input_log.front()
	var b = input_log.back()
	var slope = (b-a) / log_size
	return slope * d_tune
	
