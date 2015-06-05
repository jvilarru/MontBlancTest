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
	include gnu_compiler
	include environment_modules
}
node default {
	include all
}
node 'xubuntu-1404' {
	include extrae
}
node 'laptop' {
	include all
}
node 'davm' {
	include atlas
	include boost
	include extrae
	include fftw
	include gnu_compiler
	include hdf5
	include lapack
	include mpich
	include ompss
	include openmpi
	include papi
}
