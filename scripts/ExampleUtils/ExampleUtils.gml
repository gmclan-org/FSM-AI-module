function delta_time_seconds() {
	return delta_time * 0.000001;
}

function is_instance_in_clear_vision(instance, radius, angle, obstacle) {
	if (point_distance(x, y, instance.x, instance.y) > radius) {
		return false;
	}
	if (abs(angle_difference(direction, point_direction(x, y, instance.x, instance.y))) > angle) {
		return false;
	}
	return !collision_line(x, y, instance.x, instance.y, obstacle, false, false);
}
