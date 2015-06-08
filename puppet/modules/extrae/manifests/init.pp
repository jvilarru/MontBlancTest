#dependences = binutils-dev,libxml2-dev,gfortran,libiberty-dev
class extrae (  $unwind='',
		$papi='',
		$mpi='',
		$opencl='',
		$boost='',
		$fft='',
){
	$CFLAGS="-O3 -funwind-tables -g"
	build_source{"$module_name":
		url             => "$module_name/extrae-3.1.0.tar.bz2",
		env	            => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=-O3"],
		options         => template("$module_name/options.erb"),
		version         => "3.1.0",
		module_type     => 'tools', 
		packages        => ["gfortran","libxml2-dev","binutils-dev","libiberty-dev","dpkg-dev"],
		module_type     => "tools",
		module_app_name => "extrae",
		module_desc     => "Extrae Tool"
	}
}
