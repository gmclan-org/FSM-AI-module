if (!is_undefined(_agent)) {
	_agent.Dispose();
	_agent = undefined;
}
if (!is_undefined(_path)) {
	path_delete(_path);
	_path = undefined;
}