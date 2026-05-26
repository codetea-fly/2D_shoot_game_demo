extends Area2D

signal hit
var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	die()

func die()->void:
	if hp <= 0:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	if body.is_in_group("arrows"):
		hp -= 10
		$Control/HBoxContainer/Label.text = "HP:" + str(hp)
		$Control/HBoxContainer/ColorRect.custom_minimum_size = Vector2(hp/100.0 * 50,0)
		$AnimationPlayer.play("hit")
		body.queue_free()
