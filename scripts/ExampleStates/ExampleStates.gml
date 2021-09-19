function ExampleStateReturnToArea(name) : FsmState(name) constructor {
	static OnDecide = function(agent, sharedMemory = {}) {
		if (is_player_in_clear_vision(agent)) {
			return "pursue";
		}
		if (!is_moving_on_path(agent)) {
			return "patrol";
		}
	}

	static OnEnter = function(agent, sharedMemory = {}) {
		with(agent.localMemory) {
			image_index = 0;
			if (path_exists(pathAssigned)) {
				_path = path_add();
				mp_grid_path(
					global.mpGrid,
					_path,
					x,
					y,
					path_get_point_x(pathAssigned, 0),
					path_get_point_y(pathAssigned, 0),
					false,
				);
				path_start(_path, stepSize, path_action_stop, true);
			}
		}
	}
	
	static OnExit = function(agent, sharedMemory = {}) {
		with(agent.localMemory) {
			path_end();
			path_delete(_path);
			_path = undefined;
		}
	}
}

function ExampleStatePatrol(name) : FsmState(name) constructor {
	static OnDecide = function(agent, sharedMemory = {}) {
		if (is_player_in_clear_vision(agent)) {
			return "pursue";
		}
	}

	static OnEnter = function(agent, sharedMemory = {}) {
		with(agent.localMemory) {
			image_index = 0;
			if (path_exists(pathAssigned)) {
				var action = path_action_reverse;
				if (path_get_closed(pathAssigned)) {
					action = path_action_restart;
				}
				path_start(pathAssigned, stepSize, action, true);
			}
		}
	}
	
	static OnExit = function(agent, sharedMemory = {}) {
		with(agent.localMemory) {
			path_end();
		}
	}
}

function ExampleStatePursue(name) : FsmState(name) constructor {
	static OnDecide = function(agent, sharedMemory = {}) {
		if (!is_player_in_clear_vision(agent)) {
			return "search";
		}
	}

	static OnEnter = function(agent, sharedMemory = {}) {
		with(agent.localMemory) {
			image_index = 2;
		}
	}
	
	static OnUpdate = function(agent, sharedMemory = {}) {
		with(agent.localMemory) {
			if (_playerInClearVision) {
				mp_potential_step(_lastPlayerPos.x, _lastPlayerPos.y, stepSize, false);
			}
		}
	}
}

function ExampleStateSearch(name) : FsmState(name) constructor {
	static OnDecide = function(agent, sharedMemory = {}) {
		if (is_player_in_clear_vision(agent)) {
			return "pursue";
		}
		if (!is_moving_on_path(agent)) {
			return "look-around";
		}
	}

	static OnEnter = function(agent, sharedMemory = {}) {
		with(agent.localMemory) {
			image_index = 1;
			_path = path_add();
			mp_grid_path(
				global.mpGrid,
				_path,
				x,
				y,
				_lastPlayerPos.x,
				_lastPlayerPos.y,
				false,
			);
			path_start(_path, stepSize, path_action_stop, true);
		}
	}
	
	static OnExit = function(agent, sharedMemory = {}) {
		with(agent.localMemory) {
			path_end();
			path_delete(_path);
			_path = undefined;
		}
	}
}

function ExampleStateLookAround(name, rate = 180) : FsmState(name) constructor {
	_rate = rate;
	
	static OnDecide = function(agent, sharedMemory = {}) {
		if (is_player_in_clear_vision(agent)) {
			return "pursue";
		}
	}

	static OnEnter = function(agent, sharedMemory = {}) {
		with(agent.localMemory) {
			alarm_set(0, 90);
		}
	}
	
	static OnUpdate = function(agent, sharedMemory = {}) {
		var r = _rate;
		with(agent.localMemory) {
			direction += r * delta_time_seconds();
		}
	}
}
