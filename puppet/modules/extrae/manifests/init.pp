#dependences = binutils-dev,libxml2-dev,gfortran,libiberty-dev
class extrae (  $unwind='',
		$papi='/opt/papi/5.4.1',
		$mpi='/opt/mpich/3.1.4',
		$mpi_flavour='mpich',
		$opencl='',
		$boost='/opt/boost/1.58.0',
		$fft='/opt/fftw/3.3.4',
){
	$CFLAGS="-O3 -funwind-tables -g"
	if ( $mpi == '' ) {
		build_source{"$module_name":
			url             => "$module_name/extrae-3.1.0.tar.bz2",
			env             => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=-O3"],
			options         => template("$module_name/options.erb"),
			dest            => "/opt/extrae/3.1.0/no_mpi",
			version         => "3.1.0",
			packages        => ["gfortran","libxml2-dev","binutils-dev","libiberty-dev","dpkg-dev"],
			module_type     => "tools",
			module_app_name => "extrae",
			module_desc     => "Extrae Tool"
		}
	} else {
		build_source{"$module_name":
			url             => "$module_name/extrae-3.1.0.tar.bz2",
			env             => ["CFLAGS=$CFLAGS","CXXFLAGS=$CFLAGS","FCFLAGS=-O3"],
			dest            => "/opt/extrae/3.1.0/$mpi_flavour",
			options         => template("$module_name/options.erb"),
			version         => "3.1.0",
			packages        => ["gfortran","libxml2-dev","binutils-dev","libiberty-dev","dpkg-dev"],
			module_type     => "tools",
			module_app_name => "extrae",
			module_desc     => "Extrae Tool"
		}
	}
}
