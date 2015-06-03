define build_source::compile(
	$sourceFolder, 
	$dest = "/opt/$title", 
	$options = '', 
	$environment = '',
	$postConfigure = '',
	$buildDir = '',
	$timeout = '0', 
	$dependences = '',
	$make_args = '',
) {
	require stdlib
	$class_dependences = ['gcc','make','g++']
	ensure_resource('secure_package',$class_dependences,{})
	Package[$class_dependences] -> Exec["./configure for $title"]
	if ($dependences != ''){
		ensure_resource('secure_package',$dependences,{})
		Package[$dependences] -> Exec["./configure for $title"]
	}

	if ($environment != '') {
		Exec {
			environment => $environment
		}
	}

	if ($buildDir != '') {
		$workDir="$sourceFolder/$buildDir"
	} else {
		$workDir="$sourceFolder"
	}
	ensure_resource('file',$workDir,{'ensure' => 'directory','owner'=>'root','group'=>'root'})
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
		command => "make $make_args",
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
