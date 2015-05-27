define build_source::compile(
	$sourceFolder, 
	$dest = "/opt/$title", 
	$options = '', 
	$environment = '',
	$timeout = '0', 
) {
	
	if ($environment != '') {
		Exec {
			environment => $environment
		}
	}
	Exec {
		user    => 'root',
		timeout => $timeout,
		path    => '/usr/bin:/bin',
		cwd => "$sourceFolder",
	}
	notify {"$sourceFolder/configure ${options} --prefix=$dest":}
	exec { "./configure for $title":
		command => "$sourceFolder/configure ${options} --prefix=$dest",
		creates => "$dest"
	} ->
	
	exec { "make for $title":
		command => 'make -j',
		creates => "$dest"
	} ->
  
	exec { "make install for $title":
		command => 'make install',
		creates => "$dest"
	}
}
