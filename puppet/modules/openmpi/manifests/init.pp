#dependences = g++, gfortran, hwloc
class openmpi (  $slurm=''
){
	$CFLAGS="-O3"
	$FCFLAGS="-O3"
	build_source::install{"openmpi":
		url          => "http://www.open-mpi.org/software/ompi/v1.8/downloads/openmpi-1.8.3.tar.gz",
		environment  => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=$FCFLAGS"],
		options      => template("openmpi/options.erb"),
		version      => "1.8.3",
		dependences  => ["gfortran","libhwloc-dev"]
	}
}
