define build_source::git(
	$url, 
	$version = '',
	$dest = '', 
) {
	secure_package{"git":}
	Exec {
		user    => 'root',
		timeout => $timeout,
		path    => '/usr/bin:/bin',
	}
	if ($dest == '') {
		if ($version == '') {
			$gitDest="/usr/src/$name"
		}
		else {
			$gitDest="/usr/src/${name}/${version}"
		}	
	}
	else {
		$gitDest=$dest
	}
	exec { "Clone $title":
       		command => "git clone $url $gitDest",
		creates => $gitDest,
		require => Package["git"]
	}
}
