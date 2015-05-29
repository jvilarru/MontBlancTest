class boost {
	$version = "1.58.0"
	$srcDest = "/usr/src/$module_name/$version"
	$dest = "/opt/$module_name/$version"
	Exec {
                user    => 'root',
                timeout => 0,
		path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
		cwd     => $srcDest
        }	
	build_source::archive{"$module_name":
		url     => "http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz",
		version => $version,
		creates => "bootstrap.sh"
	}->
	exec { "$module_name bootstrap":
		command => "$srcDest/bootstrap.sh --prefix=$dest":
	}->
	exec { "$module_name install":
		command => "$srcDest/b2 install":
	}
}
