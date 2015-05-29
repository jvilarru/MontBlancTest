define safeInstall {
	unless defined(Package["$name"]) {
		 package{$name:
			ensure =>latest
		 }
	}
}

define build_source::install (  $url,
				$environment='',
				$options='',
				$version='',
				$srcDest='',
				$dest='',
				$dependences='',
				$preConfigure='',
				$postConfigure='',
){
	if($dependences!=''){
		safeInstall{ $dependences:}
	}
	if($srcDest == ''){
		if($version == ''){
			$sourceFolder = "/usr/src/$name"
		}
		else {
			file {"/usr/src/$name":
				ensure => directory,
				owner  => 'root',
				group  => 'root',
			}
			$sourceFolder = "/usr/src/$name/$version"
		}
	}
	else {
		$sourceFolder = $srcDest
	}
	if($dest == ''){
		if($version == ''){
			$destFolder = "/opt/$name"
		}
		else {
			$destFolder = "/opt/$name/$version"
		}
	}
	else {
		$destFolder = $dest
	}
	if ($preConfigure!=''){
		exec {"preconfigure of $title":
			command => $preConfigure,
			path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
			user    => 'root',
			group   => 'root',
			cwd     => "$sourceFolder",
			creates => $destFolder,
			before  => Build_source::Compile["$title"],
			require => Build_source::Archive["$title"]
		}
	}
	build_source::archive{"$title":
		url    => $url,
		dest   => $sourceFolder,
	}->
	build_source::compile{"$title":
		sourceFolder  => $sourceFolder,
		environment   => $environment,
		postConfigure => $postConfigure,
		options       => $options,
		dest          => $destFolder
	}

}
