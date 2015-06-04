class all {
	build_source{ "fftw":
	        url     => "http://www.fftw.org/fftw-3.3.4.tar.gz",
	}
	include mpich
	include extrae
	include openmpi
	include papi
	include hdf5
	include boost
	include lapack
	#include atlas
	#include gnu_compiler
	class {"environment_modules":
		types => ['compilers','tools','applications']
	}
}
node default {
	include all
}
#node 'xubuntu-1404' {
#	include boost
#}
node 'laptop' {
	include all
}
node 'davm' {
	include gnu_compiler
	include environment_modules
}
