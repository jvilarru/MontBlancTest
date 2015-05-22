define build_source::install(
	$sourceFolder, 
	$dest = "/opt/$name", 
	$options = '', 
	$timeout = '0', 
) {
	Exec {
		user    => 'root',
		timeout => $timeout,
		path    => '/usr/bin:/bin',
		cwd => "$sourceFolder",
	}
	exec { "./configure for $title":
		command => "$sourceFolder/configure ${options} --prefix=$dest",
	} ->
	
	exec { "make for $title":
		command => 'make -j',
	} ->
  
	exec { "make install for $title":
		command => 'make install',
	}
}
