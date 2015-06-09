class scientific_libraries {
	class{"hdf5":
		mpi     => "/opt/mpich/3.1.4",
		require => Class['mpich']
	}
	include fftw
	include boost
	include lapack
	include opengl
	include atlas
}
