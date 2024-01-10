extends ProgressBar

@onready var player_stats = $"../../Player/Job/Stats"

func _ready():
	player_stats.connect("health_changed", update_health_bar)

func update_health_bar():
	print("health bar connected")
