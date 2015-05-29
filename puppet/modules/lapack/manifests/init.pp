class lapack {
	$version = "3.5.0"
	build_source::archive{"$module_name":
		url     => "http://www.netlib.org/lapack/lapack-3.5.0.tgz",
		version => "3.5.0",
		creates => "CMakeLists.txt"
	}
	build_source::cmake{"$module_name":
		sourceFolder => "/usr/src/$module_name/$version",
		dest         => "/opt/$module_name/$version"
	}
}
