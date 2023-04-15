extends Particles2D

func _on_Timer_timeout():
	if(!emitting):
		queue_free()
	emitting = false
	$Timer.start()
