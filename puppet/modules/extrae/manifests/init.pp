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
	build_source::install{"$module_name":
		url          => "$module_name/extrae-3.1.0.tar.bz2",
		environment  => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=-O3"],
		options      => template("$module_name/options.erb"),
		version      => "3.1.0",
		dependences => ["gfortran","libxml2-dev","binutils-dev","libiberty-dev","dpkg-dev"]
	}
}
