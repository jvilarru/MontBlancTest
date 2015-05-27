node 'xubuntu-1404' {
	include build_source
	#include ompss
	#	class{"extrae":
	#}
	archive { 'fftw':
		ensure => present,
		url    => "http://www.fftw.org/fftw-3.3.4.tar.gz",
		target => "/tmp"
	}	
}
node 'laptop' {
	include stdlib
	include build_source
	class{"extrae":
	}
#	include ompss
}
