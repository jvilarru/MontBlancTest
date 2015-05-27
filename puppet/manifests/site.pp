node 'xubuntu-1404' {
	include build_source
	#include ompss
	#	class{"extrae":
	#}
}
node 'laptop' {
	#	include stdlib
	#	include build_source
	#	class{"extrae":
	#	}
#	include ompss
	build_source::archive{ "fftw":
		url     => "http://www.fftw.org/fftw-3.3.4.tar.gz",
		version => '3.3.4'
	}
}
