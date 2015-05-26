define build_source::archive(
	$url,
	$version = '',
	$dest = '', 
	$extension = 'tar.gz', 
) {
	Exec {
		user    => 'root',
		timeout => $timeout,
		path    => '/usr/bin:/bin',
	}
	if ($dest == '') {
		if ($version == '') {
			$archiveDest="/usr/src/$name"
		}
		else {
			$archiveDest="/usr/src/${name}/${version}"
		}	
	}
	else {
		$archiveDest=$dest
	}
	file { "$archiveDest":
		ensure => directory,
		owner => 'root',
		group => 'root',
	}
	exec { "Download $title":
		command => "wget $url -O $name.${extension}",
		cwd => "/tmp",
		creates => "/tmp/$name.${extension}" 
	}->
	exec { "Extract $title":
       		command => "tar xf /tmp/$name.${extension}",
		cwd => "$archiveDest",
	}
}
