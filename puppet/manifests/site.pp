node 'xubuntu-1404' {
	include build_source
	build_source::install {"fftw":
		url => "https://github.com/FFTW/fftw3.git",
	}
#	build_source::git {"fftw":
#		url => "https://github.com/FFTW/fftw3.git",
#		version => "3"
#	}
}
