define build_source::compile(
	$sourceFolder, 
	$dest = "/opt/$title", 
	$options = '', 
	$environment = '',
	$postConfigure = '',
	$buildDir = '',
	$timeout = '0', 
	$dependences = '',
) {
	require stdlib
	ensure_packages(['gcc','make','g++'])
	if ($dependences != ''){
		ensure_packages($dependences)
		Package[$dependences] -> Exec["./configure for $title"]
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

	exec { "./configure for $title":
		command   => "$sourceFolder/configure --prefix=$dest $options",
		logoutput => 'on_failure',
		creates   => "$dest",
	}
	
	exec { "make for $title":
		command => 'make',
		creates => "$dest",
		require => Exec["./configure for $title"]

	}
  
	exec { "make install for $title":
		command => 'make install',
		creates => "$dest",
		require => Exec["make for $title"]
	}

	if ($postConfigure != ''){
		exec {"postconfigure of $title":		
                        command => $postConfigure,
			creates => $dest,
                        before  => Exec["make for $title"],
                        require => Exec["./configure for $title"]
                }	
	}
}
