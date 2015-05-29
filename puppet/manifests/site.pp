class test {
	build_source::install{ "fftw":
	        url     => "https://github.com/FFTW/fftw3.git",
	}
	include extrae
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
