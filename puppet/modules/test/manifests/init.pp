define test ($type='configure') {
	case $type {
		'cmake': { notice("$title --> $type")}
		'configure': { notice("$title --> $type")}
		'booststrap': { notice("$title --> $type")}
		default: { fail('Type of installation not supported')}
	}
}
