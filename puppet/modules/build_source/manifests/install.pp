define build_source::install(
	$url, 
	$dest = "/opt/$name", 
	$fileExtension = ".tar.gz", 
	$options = '', 
	$timeout = '0', 
	$delSources = true 
) {
	$fileDownload = inline_template('<%= File.basename(@url) %>')
	$fileExtracted = inline_template('<%= File.basename(@url,@fileExtension) %>')
	$fileExtension = inline_template('<%= File.extname(@url) %>')
	#notify {"$fileExtracted":}
	Exec {
		user    => 'root',
		timeout => $timeout,
		path    => '/usr/bin:/bin',
	}
	if ($fileExtension != ".git") {
		exec { "Download $title":
			command => "wget $url -O $fileDownload",
			cwd => "/tmp",
			creates => $dest,
		} -> 
		
		exec { "Extract $title":
			command => "tar xf /tmp/$fileDownload",
			cwd => "/usr/src",
		}
	} else {
		exec { "Clone $title":
                        command => "git clone $url $name",
                        cwd => "/usr/src",
                        creates => $dest,
                }
	} ->
	
	exec { "./configure in /usr/src/$title":
		command => "/usr/src/$fileExtracted/configure ${options} --prefix=$dest",
		cwd => "/usr/src/$fileExtracted",
	} ->
	
	exec { "make in /usr/src/$title":
		command => 'make -j',
		cwd => "/usr/src/$fileExtracted",
	} ->
  
	exec { "make install in $dest":
		command => 'make install',
		cwd => "/usr/src/$fileExtracted",
		notify => Exec["delete sources $title"],
	}
    
	if ($delSources) {
		exec { "delete sources $title" :
			command => "rm -rf /usr/src/$fileExtracted",
			refreshonly => true,
		}
		file { "/tmp/$fileDownload":
			ensure => absent,
			require => Exec["make install in $dest"] 
		}
	}
}
