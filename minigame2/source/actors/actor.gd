extends KinematicBody2D
class_name Actor

export var speed:= Vector2(300.0, 1000.0)
export var acceleration:=4000.0 #to make this configurable
var velocity:=Vector2.ZERO #since we're only dealing with 2d/ movement on x and y axis per second/ zero by default->will not move by default
