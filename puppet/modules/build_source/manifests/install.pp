define build_source::install (  $url,
				$environment='',
				$options='',
				$version='',
				$srcDest='',
				$dest='',
				$buildDir='',
				$configureLocation='',
				$preConfigure='',
				$postConfigure='',
				$dependences='',
){
	require stdlib
	if ($dependences!='') {
		ensure_packages($dependences)
		Package[$dependences] -> Build_source::Compile["$title"]
	}
	if($srcDest == ''){
		if($version == ''){
			$_sourceFolder = "/usr/src/$name"
		}
		else {
			file {"/usr/src/$name":
				ensure => directory,
				owner  => 'root',
				group  => 'root',
			}
			$_sourceFolder = "/usr/src/$name/$version"
		}
	}
	else {
		$_sourceFolder = $srcDest
	}
	if($configureLocation == ''){
		$sourceFolder = $_sourceFolder
	} else {
		$sourceFolder = "$_sourceFolder/$configureLocation"
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
	$extension = inline_template('<%= File.extname(@url) %>')
	if($extension == ".git"){
		build_source::git{"$title":
			url    => $url,
			dest   => $_sourceFolder,
			before => Build_source::Compile["$title"]
		}
		$requirement="Build_source::Git"
	} else {
		build_source::archive{"$title":
			url          => $url,
			dest         => $_sourceFolder,
			configureAdd => $configureLocation,
			before       => Build_source::Compile["$title"]
		}
		$requirement="Build_source::Git"

	}
	if ($preConfigure!=''){
		exec {"preconfigure of $title":
			command => $preConfigure,
			path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
			user    => 'root',
			group   => 'root',
			cwd     => $sourceFolder,
			creates => $destFolder,
			before  => Build_source::Compile["$title"],
			require => $requirement["$title"]
			#AIXO DE ADALT NI PUTA IDEA SI FUNCARA
		}
	}
	build_source::compile{"$title":
		sourceFolder      => $sourceFolder,
		environment       => $environment,
		postConfigure     => $postConfigure,
		buildDir          => $buildDir,
		options           => $options,
		dest              => $destFolder
	}

}
