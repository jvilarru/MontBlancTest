#dependences = binutils-dev, libxml2-dev gfortran
class extrae (  $unwind='',
		$papi='',
		$mpi='',
		$opencl='',
		$boost='',
		$fft='',
		$ver = '',
){
	#$CFLAGS="-O3 -mcpu=$cortex_cpu -mtune=$cortex_cpu -mfpu=$fpu -funwind-tables -g"
	$CFLAGS="-O3 -funwind-tables -g"
	$sourcePath = "/usr/src/extrae-3.1.0"
	file{"/tmp/extrae-3.1.0.tar.bz2":
		ensure => file,
		source => 'puppet:///modules/extrae/extrae-3.1.0.tar.bz2',
		owner  => 'root',
		group  => 'root',
		mode   => '644'
	}->
	exec{"extract extrae":
		user    => 'root',
		command => 'tar xf /tmp/extrae-3.1.0.tar.bz2',
		path    => '/bin:/usr/bin',
		cwd     => "/usr/src",
		creates => "/usr/src/extrae-3.1.0",
	}->
	build_source::install{"extrae":
		sourceFolder => $sourcePath,
		environment => ["CFLAGS=\"$CFLAGS\"","CXXFLAGS=\"$CFLAGS\"","FCFLAGS=\"-O3\""],
		options => template("extrae/options.erb"),
	}

}
