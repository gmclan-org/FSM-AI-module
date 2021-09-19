function FsmState(name) constructor {
	_name = string(name);
	
	static OnDecide = function(agent, sharedMemory = {}) {}
	static OnEnter = function(agent, sharedMemory = {}) {}
	static OnExit = function(agent, sharedMemory = {}) {}
	static OnUpdate = function(agent, sharedMemory = {}) {}
	
	static Name = function() {
		return _name;
	}
	
	static Dispose = function() {}
}
