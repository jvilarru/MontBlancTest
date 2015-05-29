class boost {
	$version = "1.58.0"
	build_source::archive{"$module_name":
		url     => "http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz",
		version => $version,
		creates => "bootstrap.sh"
	}->
	build_source::bootstrap{"$module_name":
		sourceFolder => "/usr/src/$module_name/$version",
		dest         => "/opt/$module_name/$version",
		builder      => "b2",
		dependences  => ["python-dev","libxml2-dev","libxslt1-dev","libbz2-dev"]
	}
}
