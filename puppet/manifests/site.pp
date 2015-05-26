node 'xubuntu-1404' {
	include build_source
	#include ompss
	class{"extrae":
	}
}
node 'laptop' {
	include stdlib
	include build_source
	class{"extrae":
	}
#	include ompss
}
