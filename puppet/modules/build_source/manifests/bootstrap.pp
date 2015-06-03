define build_source::bootstrap(
	$sourceFolder, 
	$dest = "/opt/$title", 
	$options = '', 
	$builder = "$title",
	$environment = '',
	$buildDir = '',
	$timeout = '0', 
	$dependences ='',
) {
	require stdlib
        if ($dependences!='') {
                secure_package{$dependences:}
                Package[$dependences] -> Exec["bootstrap $title"]
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
	ensure_resource('file',$workDir,{'ensure' => 'directory','owner'  => 'root','group'  => 'root'})
	Exec {
		user     => 'root',
		group    => 'root',
		timeout  => $timeout,
		path     => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
		cwd      => "$workDir",
	}
	exec { "bootstrap $title":
		command   => "$sourceFolder/bootstrap.sh --prefix=$dest",
		logoutput => 'on_failure',
		creates   => "$dest",
	}
	
	exec { "$builder --> $title":
		command => "$sourceFolder/$builder",
		creates => "$dest",
		require   => Exec["bootstrap $title"]	
	}
	exec { "$builder install --> $title":
		command => "$sourceFolder/$builder install",
		creates => "$dest",
		require   => Exec["$builder --> $title"]
	}
}
