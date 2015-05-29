define build_source::compile(
	$sourceFolder, 
	$dest = "/opt/$title", 
	$options = '', 
	$environment = '',
	$postConfigure = '',
	$workDir = '',
	$timeout = '0', 
) {
	if ($environment != '') {
		Exec {
			environment => $environment
		}
	}
	if ($workDir != '') {
		$realWorkDir="$sourceFolder/$workDir"
		file {$realWorkDir:
			ensure => directory,
			owner  => 'root',
			group  => 'root',
		}
	} else {
		$realWorkDir="$sourceFolder"
	}
	Exec {
		user     => 'root',
		group    => 'root',
		timeout  => $timeout,
		path     => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
		cwd      => "$realWorkDir",
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
	if ($postConfigure != ''){
		exec {"postconfigure of $title":		
                        command => $postConfigure,
			creates => $dest,
                        before  => Exec["make for $title"],
                        require => Exec["./configure for $title"]
                }	
	}
}
