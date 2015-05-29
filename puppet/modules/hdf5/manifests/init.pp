#dependences = 
class hdf5 (
		$mpi='',
) {
	$CFLAGS="-O3"
	$FCFLAGS="-O3"
	build_source::install{"hdf5":
		url          => "http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.15.tar",
		environment  => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=-O3"],
		options      => template("hdf5/options.erb"),
		version      => "1.8.15",
	}
}
