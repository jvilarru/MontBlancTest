class test {
	build_source::install{ "fftw":
	        url     => "https://github.com/FFTW/fftw3.git",
	}
	include extrae
	include mpich
	include openmpi
	include papi
	include hdf5
	include boost
}
node 'xubuntu-1404' {
	include test
}
node 'laptop' {
	include test
}
node default {
	include test
}
