function is_moving_on_path(agent) {
	return path_exists(agent.localMemory.path_index) && agent.localMemory.path_position < 1;
}

function is_player_in_clear_vision(agent) {
	return agent.localMemory._playerInClearVision;
}
