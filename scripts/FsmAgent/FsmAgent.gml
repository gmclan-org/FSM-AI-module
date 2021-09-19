function FsmAgent(states = [], _localMemory = {}) constructor {
	localMemory = _localMemory;
	_states = states;
	_activeStateName = undefined;
	
	static HasActiveState = function() {
		return is_string(_activeStateName);
	}
	
	static ActiveStateName = function() {
		return _activeStateName;
	}
	
	static ActiveState = function() {
		return State(ActiveStateName());
	}
	
	static State = function(name) {
		if (is_string(name)) {
			for (var i = 0; i < array_length(_states); ++i) {
				var state = _states[i];
				if (state.Name() == name) {
					return state;
				}
			}
		}
		return undefined;
	}
	
	static ChangeActiveState = function(name, sharedMemory = {}) {
		if (_activeStateName == name) {
			return false;
		}
		var newState = State(name);
		if (is_undefined(newState)) {
			return false;
		}
		var oldState = ActiveState();
		if (!is_undefined(oldState)) {
			oldState.OnExit(self, sharedMemory);
		}
		if (is_undefined(newState)) {
			_activeStateName = undefined;
		} else {
			newState.OnEnter(self, sharedMemory);
			_activeStateName = name;
		}
		return true;
	}
	
	static Decide = function(sharedMemory = {}) {
		var state = ActiveState();
		if (!is_undefined(state)) {
			var name = state.OnDecide(self, sharedMemory);
			if (is_string(name)) {
				return ChangeActiveState(name, localMemory, sharedMemory);
			}
		}
		return false;
	}
	
	static Update = function(sharedMemory = {}) {
		var state = ActiveState();
		if (!is_undefined(state)) {
			state.OnUpdate(self, sharedMemory);
		}
	}
	
	static Dispose = function() {
		for (var i = 0; i < array_length(_states); ++i) {
			var state = _states[i];
			if (!is_undefined(state)) {
				state.Dispose();
			}
		}
		localMemory = {};
		_states = [];
		_activeStateName = undefined;
	}
}
