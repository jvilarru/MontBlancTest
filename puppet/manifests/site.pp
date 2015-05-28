node 'xubuntu-1404' {
	build_source::install{ "fftw":
	        url     => "http://www.fftw.org/fftw-3.3.4.tar.gz",
	}
	include extrae
}
node 'laptop' {
	include extrae
}
node 'ubuntu-1404-server' {
	build_source::install{ "fftw":
	        url     => "http://www.fftw.org/fftw-3.3.4.tar.gz",
	}
	include extrae
}
