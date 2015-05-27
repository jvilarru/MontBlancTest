node 'xubuntu-1404' {
	include build_source
}
node 'laptop' {
	#	build_source::install{ "fftw":
	#        url     => "http://www.fftw.org/fftw-3.3.4.tar.gz",
	#}
	include extrae
}
