extends Node

class_name CharacterStats

signal health_changed(new_health)
signal health_depleted()

var modifiers = {}

var health: int
var spell_slots: int
var max_health: int
	#set(value):
		#set_max_health(value)
	#get:
		#return max_health
var max_spell_slots: int
	#set(value):
		#set_max_spell_slots(value)
	#get:
		#return max_spell_slots
var armor_class: int
var strength: int
var dexterity: int
var constitution: int
var intelligence: int
var wisdom: int
var charisma: int

#sets the starting stats based on the character's job
func initialize(stats: StartingStats) -> void:
	max_health = stats.max_health
	emit_signal("health_changed")
	max_spell_slots = stats.max_spell_slots
	armor_class = stats.armor_class
	strength = stats.strength
	dexterity = stats.dexterity
	constitution = stats.constitution
	intelligence = stats.intelligence
	wisdom = stats.wisdom
	charisma = stats.charisma

#func set_max_health(value):
	#max_health = max(0, value)
#
#func set_max_spell_slots(value):
	#max_spell_slots = max(0, value)

#subtracts health upon getting hit, signals that this has happened
#signals if the character hits 0 health
func take_damage(hit):
	health -= hit.damage
	health = max(0, health)
	emit_signal("health_changed", health)
	if health == 0:
		emit_signal("health_depleted")

#heals the character, signals that this has happened
func heal(heal_value):
	health += heal_value
	health = max(health, max_health)
	emit_signal("health_changed", heal_value)

func add_modifier(id, modifier):
	modifiers[id] = modifier

func remove_modifier(id):
	modifiers.erase(id)
