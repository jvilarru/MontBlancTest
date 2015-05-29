class lapack {
	$version = "3.5.0"
	$srcDest = "/usr/src/$module_name/$version"
	$dest = "/opt/$module_name/$version"
	ensure_package(["cmake"])
	Exec {
                user    => 'root',
                timeout => 0,
                path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
                cwd     => $srcDest
        }
	build_source::archive{"$module_name":
		url     => "http://www.netlib.org/lapack/lapack-3.5.0.tgz",
		version => $version
	}
	exec { "cmake $module_name":
		command =>"cmake -D CMAKE_INSTALL_PREFIX=$dest $srcDest",
		require => Package['cmake']
	}->
	exec { "make $module_name":
		command => "make"
	}->
	exec { "make install $module_name":
		command => "make install"
	}
}
