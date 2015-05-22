define build_source::git(
	$url, 
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
			$gitDest=$name
		}
		else {
			$gitDest="${name}/${version}"
		}	
	}
	else {
		$gitDest=$dest
	}
	exec { "Clone $title":
       		command => "git clone $url $gitDest",
		cwd => "/usr/src",
		creates => "/usr/src/$gitDest",
	}
}