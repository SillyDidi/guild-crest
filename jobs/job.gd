extends Node

class_name Job


@onready var stats = $Stats
@onready var skills = $Skills

@export var starting_stats: StartingStats
@export var starting_skills: Skill
@export var character_skill_scene: PackedScene

func _ready():
	stats.initialize(starting_stats)
