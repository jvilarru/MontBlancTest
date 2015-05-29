#dependences = g++, gfortran, libcr-dev
class mpich (  $blcr='',
		$slurm='',
){
	$CFLAGS="-O3"
	$FCFLAGS="-O3"
	$FFLAGS="-O3"
	build_source::install{"mpich":
		url          => "http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz",
		environment  => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=$FCFLAGS","FFLAGS=$FFLAGS"],
		options      => template("mpich/options.erb"),
		version      => "3.1.4",
		dependences  => ["gfortran","g++","libcr-dev"]
	}
}
