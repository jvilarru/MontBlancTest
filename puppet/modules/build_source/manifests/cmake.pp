define build_source::cmake(
	$sourceFolder, 
	$dest = "/opt/$title", 
	$options = '', 
	$environment = '',
	$buildDir = '',
	$timeout = '0', 
	$dependences = '',
) {
	require stdlib
	ensure_packages(["cmake","gcc","make","g++"])
        if ($dependences!='') {
                ensure_packages($dependences)
                Package[$dependences] -> Exec["cmake for $title"]
        }

	if ($environment != '') {
		Exec {
			environment => $environment
		}
	}

	if ($buildDir != '') {
		$workDir="$sourceFolder/$buildDir"
		file {$workDir:
			ensure => directory,
			owner  => 'root',
			group  => 'root',
		}
	} else {
		$workDir="$sourceFolder"
	}

	Exec {
		user     => 'root',
		group    => 'root',
		timeout  => $timeout,
		path     => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
		cwd      => "$workDir",
	}

	exec { "cmake for $title":
		command   => "cmake -D CMAKE_INSTALL_PREFIX=$dest $options $sourceFolder",
		logoutput => 'on_failure',
		creates   => "$dest",
	}
	
	exec { "make for $title":
		command => 'make',
		creates => "$dest",
		require => Exec["cmake for $title"]
	}
  
	exec { "make install for $title":
		command => 'make install',
		creates => "$dest",
		require => Exec["make for $title"]
	}
}
