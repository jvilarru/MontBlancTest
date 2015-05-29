#dependences = g++, gfortran, libcr-dev
class mpich (  $blcr='',
		$slurm='',
){
	$CFLAGS="-O3"
	$FCFLAGS="-O3"
	$FFLAGS="-O3"
	build_source::install{"$module_name":
		url          => "http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz",
		environment  => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=$FCFLAGS","FFLAGS=$FFLAGS"],
		options      => template("$module_name/options.erb"),
		version      => "3.1.4",
		dependences  => ["gfortran","libcr-dev"]
	}
}
