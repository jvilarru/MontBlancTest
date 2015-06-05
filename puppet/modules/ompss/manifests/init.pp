#dependences = binutils-dev,libxml2-dev,gfortran,libiberty-dev
class ompss (  $opencl='',
		$extrae='',
		$mpi='',
){
	# Some preparations
	require stdlib
	$mcxx_dependences = ["bison","flex","gperf"]
	$nanox_dependences = ["libsqlite3-dev"]
	ensure_resource('secure_package',$mcxx_dependences,{})
	ensure_resource('secure_package',$nanox_dependences,{})

	# Download the OmpSs tarball
	build_source::archive{"$module_name download and extraction":
		url     => "http://pm.bsc.es/sites/default/files/ftp/ompss/releases/ompss-latest.tar.gz",
		dest    => "/usr/src/ompss",
		creates => "/usr/src/ompss",
	}

	# We need to rename the folders...
	#	Exec {
	#		user    => 'root',
	#		group   => 'root',
	#		path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
	#	}
	#	exec {"rename nanox folder":
	#		command => "mv /usr/src/ompss/nanox-* /usr/src/ompss/nanox",
	#		require => Build_source::Archive["$module_name download and extraction"]
	#	}
	#	exec {"rename mercurium folder":
	#		command => "mv /usr/src/ompss/mcxx-* /usr/src/ompss/mcxx",
	#		require => Build_source::Archive["$module_name download and extraction"]
	#	}

	# Compile Nanox
	$NANOX_CFLAGS="-O3"
	$NANOX_CXXFLAGS="-O3"
	$NANOX_FCFLAGS="-O3"
	Secure_package[$nanox_dependences] -> build_source::compile{"$module_name nanox compilation":
		sourceFolder => "/usr/src/ompss/nanox-0.7.11",
		environment  => ["CFLAGS=$NANOX_CFLAGS","CXXFLAGS=$NANOX_CXXFLAGS","FCFLAGS=$NANOX_FCFLAGS"],
		options      => template("$module_name/nanox_options.erb"),
		dest         => "/opt/ompss/nanox",
		require      => Build_source::Archive["$module_name download and extraction"]
	}
	
	# Compile Mercurium
	$MCXX_CFLAGS="-O3"
	$MCXX_CXXFLAGS="-O3"
	$MCXX_FCFLAGS="-O3"
	Secure_package[$mcxx_dependences] -> build_source::compile{"$module_name mcxx compilation":
		sourceFolder => "/usr/src/ompss/mcxx-1.99.8",
		environment  => ["CFLAGS=$MCXX_CFLAGS","CXXFLAGS=$MCXX_CXXFLAGS","FCFLAGS=$MCXX_FCFLAGS"],
		options      => template("$module_name/mcxx_options.erb"),
		dest         => "/opt/ompss/mcxx",
		require       => Build_source::Compile["$module_name nanox compilation"]
	}
}
