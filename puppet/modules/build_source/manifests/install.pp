define build_source::install (  $url,
				$environment='',
				$options='',
				$version='',
				$srcDest='',
				$dest='',
){
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

	build_source::archive{"$title":
		url    => $url,
		dest   => $sourceFolder,
		before => Build_source::Compile["$title"]
	}->
	build_source::compile{"$title":
		sourceFolder => $sourceFolder,
		environment  => $environment,
		options      => $options,
		dest         => $destFolder
	}

}
