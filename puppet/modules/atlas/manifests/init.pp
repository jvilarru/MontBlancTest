#dependences = 
class atlas (  $archdef='',
){
	$LAPACK_TAR="/usr/src/lapack.tar.gz"
	file { "$LAPACK_TAR":
		ensure => present,
		source => "puppet:///modules/$module_name/lapack-3.5.0.tar.gz",
	}
	file { "/tmp/deactivate_throttling.sh":
		ensure => present,
		source => "puppet:///modules/$module_name/deactivate_throttling.sh",
		mode   => '755',
		owner  => 'root',
		group  => 'root',
	}
	$PROC_COUNT=$::processorcount
	exec { "deactivate_throttling.sh":
		command  => "/tmp/deactivate_throttling.sh $PROC_COUNT",
		user     => 'root',
		path     => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
		onlyif   => 'dpkg -l cpufrequtils',
		require  => File["/tmp/deactivate_throttling.sh"],
	}

	$CFLAGS="-O3"
	$ARCH_COMP=$::architecture
	build_source::install{"$module_name":
		url          => "http://sourceforge.net/projects/math-atlas/files/Developer%20%28unstable%29/3.11.34/atlas3.11.34.tar.bz2",
		version      => "3.11.34",
		require		 => [File["$LAPACK_TAR"],Exec["/tmp/deactivate_throttling.sh"]],
		buildDir     => "$ARCH_COMP",
		dependences  => ["gfortran"]
	}
}
