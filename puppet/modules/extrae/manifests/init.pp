#dependences = binutils-dev,libxml2-dev,gfortran,libiberty-dev
class extrae (  $unwind='',
		$papi='',
		$mpi='',
		$opencl='',
		$boost='',
		$fft='',
		$ver = '',
){
	$CFLAGS="-O3 -funwind-tables -g"
	build_source::install{"extrae":
		url         => "puppet:///modules/extrae/extrae-3.1.0.tar.bz2",
		environment => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=-O3"],
		options     => template("extrae/options.erb"),
		version     => "3.1.0"
	}

}
