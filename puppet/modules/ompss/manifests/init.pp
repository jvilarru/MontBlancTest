#dependences = binutils-dev,libxml2-dev,gfortran,libiberty-dev
class ompss (  $opencl='',
		$extrae='',
		$mpi='',
){
	build_source::archive{"$module_name download and extraction":
		url     => "http://pm.bsc.es/sites/default/files/ftp/ompss/releases/ompss-latest.tar.gz",
		dest    => "/usr/src/ompss",
		creates => "/usr/src/ompss",
		before  => [Build_source::Compile["nanox"],Build_source::Compile["mcxx"]]
	}

	# We need to rename the folders...
	Exec {
		user    => 'root',
		group   => 'root',
		path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
		require => Build_source::Archive["$module_name download and extraction"]
	}
	exec {"rename nanox folder":
		command => "mv /usr/src/ompss/nanox-* /usr/src/ompss/nanox"
	}
	exec {"rename mercurium folder":
		command => "mv /usr/src/ompss/mcxx-* /usr/src/ompss/mcxx"
	}

	$NANOX_CFLAGS="-O3"
	$NANOX_CXXFLAGS="-O3"
	$NANOX_FCFLAGS="-O3"
	build_source::compile{"$module_name nanox compilation":
		sourceFolder => "/usr/src/ompss/nanox",
		environment  => ["CFLAGS=$NANOX_CFLAGS","CXXFLAGS=$NANOX_CXXFLAGS","FCFLAGS=$NANOX_FCFLAGS"],
		options      => template("$module_name/nanox_options.erb"),
		dest         => "/opt/ompss/nanox",
		require      => Exec["rename nanox folder"],
		before       => Build_source::Compile["$module_name mcxx compilation"]
	}
	
	$MCXX_CFLAGS="-O3"
	$MCXX_CXXFLAGS="-O3"
	$MCXX_FCFLAGS="-O3"
	build_source::compile{"$module_name mcxx compilation":
		sourceFolder => "/usr/src/ompss/mcxx",
		environment  => ["CFLAGS=$MCXX_CFLAGS","CXXFLAGS=$MCXX_CXXFLAGS","FCFLAGS=$MCXX_FCFLAGS"],
		options      => template("$module_name/mcxx_options.erb"),
		dest         => "/opt/ompss/mcxx",
		dependences  => ["bison","flex","gperf","libsqlite3-dev"],
		require      => Exec["rename mercurium folder"]
	}
}
