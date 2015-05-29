#dependences =  gfortran, g++
class hdf5 (
		$mpi='',
) {
	$CFLAGS="-O3"
	$FCFLAGS="-O3"
	build_source::install{"$module_name":
		url          => "http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.15.tar",
		environment  => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=-O3"],
		options      => template("$module_name/options.erb"),
		version      => "1.8.15",
		dependences  => ["gfortran"]
	}
}
