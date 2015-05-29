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
		user     => 'root',
		group    => 'root',
		timeout  => $timeout,
		provider => "shell",
		path     => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
		cwd      => "$sourceFolder",
	}
	exec { "./configure for $title":
		command   => "$sourceFolder/configure ${options} --prefix=$dest",
		logoutput => 'on_failure',
		creates   => "$dest",
		require   => Class['build_source']
	} ->
	
	exec { "make for $title":
		command => 'make',
		creates => "$dest",
		require   => Class['build_source']
	} ->
  
	exec { "make install for $title":
		command => 'make install',
		creates => "$dest",
		require   => Class['build_source']
	}
}
