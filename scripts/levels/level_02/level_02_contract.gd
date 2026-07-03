extends Resource
class_name Level02Contract

const VERSION := "Level_02_Greybox_Development_Reference_v1.3.2"
const TRANSFORM_EPSILON := 0.001
const SHARD_03_TEXT := "В тебе есть свет, который не нужно делать громче"
const SHARD_04_TEXT := "Рядом с мыслью о тебе во мне больше жизни"
const MAIN_TEXT := "Мне дорого, что в тебе есть свой свет - иногда яркий, иногда совсем тихий. Его не нужно делать громче или превращать во что-то другое. Мне нравится, что он твой. И рядом с мыслью о тебе во мне становится больше жизни"
const PORTAL_TARGET := "res://scenes/levels/Level_03.tscn"
const TRIAL_B_SEQUENCE: Array[StringName] = [&"Leaf", &"Sun", &"Wave", &"Star"]

static func nearly_equal(a: float, b: float) -> bool:
	return absf(a - b) <= TRANSFORM_EPSILON
