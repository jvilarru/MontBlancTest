#dependences = 
class atlas (  $archdef='',
){
	define core_performance {
		exec {"Put core $title in performance": 
			command => "/bin/echo performance > /sys/devices/system/cpu/cpu${title}/cpufreq/scaling_governor",
			user    => 'root',
			group   => 'root',
			onlyif  => 'dpkg -l cpufrequtils',
			before  => Build_source::Install["$module_name"]
		}
	}
	require stdlib
	$cpus = range(0,$::processorcount-1)
	core_performance{$cpus:}
	file { "lapack .tar.gz functions for atlas":
		path   => ,"/tmp/lapack.tar.gz",
		ensure => present,
		source => "puppet:///modules/$module_name/lapack-3.5.0.tgz",
		before => Build_source::Install["$module_name"]
	}
	$CFLAGS="-O3"
	build_source::install{"$module_name":
		url          => "http://sourceforge.net/projects/math-atlas/files/Developer%20%28unstable%29/3.11.34/atlas3.11.34.tar.bz2",
		version      => "3.11.34",
		buildDir     => "$::architecture",
		make_args    => "build",
		dependences  => ["gfortran"]
	}
}
