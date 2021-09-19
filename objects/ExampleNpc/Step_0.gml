_delayAccum += delta_time_seconds();
if (_delayAccum >= _delayTime) {
	_delayAccum = 0;
	
	var firstCone = is_instance_in_clear_vision(ExamplePlayer, 500, 45, ExampleObstacle);
	var secondCone = is_instance_in_clear_vision(ExamplePlayer, 100, 80, ExampleObstacle);
	_playerInClearVision = firstCone || secondCone;
	
	if (_agent.HasActiveState()) {
		_agent.Decide();
	} else {
		_agent.ChangeActiveState("return");
	}
	
	if (_playerInClearVision) {
		_lastPlayerPos = { x: ExamplePlayer.x, y: ExamplePlayer.y };
	}
}
_agent.Update(self);

image_angle = direction;
