class ompss (   $mpi='',
		$extrae='',
		$opencl='',
		$bison='',
		$gperf='',
){
	$CFLAGS="-O3 -mcpu=$cortex_cpu -mtune=$cortex_cpu -mfpu=$fpu"
	build_source::git{"nanox":
		url => "http://pm.bsc.es/git/nanox.git",
		dest => "/usr/src/ompss/nanox"
	}
	build_source::git{"mcxx":
		url => "http://pm.bsc.es/git/mcxx.git",
		dest => "/usr/src/ompss/mcxx"
	}
	build_source::compile{"nanox":
		sourceFolder => "/usr/src/ompss/nanox",
		dest => "/opt/ompss/nanox",
		environment => ["CFLAGS=\"$CFLAGS\"","CXXFLAGS=\"$CFLAGS\"","FCFLAGS=\"-O3\""],
		options => "",
		require => Build_source::Git["nanox"]
	}->
	build_source::compile{"mcxx":
		sourceFolder => "/usr/src/ompss/mcxx",
		dest => "/opt/ompss/mcxx",
		environment => ["CFLAGS=\"$CFLAGS\"","CXXFLAGS=\"$CFLAGS\"","FCFLAGS=\"-O3\""],
		options => "",
		require => Build_source::Git["mcxx"]
	}

}
