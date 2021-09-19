stepSize = 3;
_delayTime = 0.2;
_delayAccum = 0;
_path = undefined;
_playerInClearVision = false;
_lastPlayerPos = { x: x, y: y };
image_speed = 0;

_agent = new FsmAgent([
	new ExampleStateReturnToArea("return"),
	new ExampleStatePatrol("patrol"),
	new ExampleStatePursue("pursue"),
	new ExampleStateSearch("search"),
	new ExampleStateLookAround("look-around"),
], self);
