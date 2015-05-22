define build_source::archive(
	$url,
	$name,
	$version = '',
	$dest = '', 
) {
	Exec {
		user    => 'root',
		timeout => $timeout,
		path    => '/usr/bin:/bin',
	}
	if ($dest == '') {
		if ($version == '') {
			$archiveDest=$name
		}
		else {
			$archiveDest="${name}/${version}"
		}	
	}
	else {
		$archiveDest=$dest
	}
	exec { "Download $title":
		command => "wget $url -O $archiveDest",
		cwd => "/tmp/${archiveDest}.${extension}"
	}->
	exec { "Extract $title":
       		command => "tar xf /tmp/${archiveDest}.${extension}",
		cwd => "/usr/src",
		creates => "/usr/src/$gitDest",
	}
}
